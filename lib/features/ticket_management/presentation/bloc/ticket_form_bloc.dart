import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/flight_segment_entity.dart';
import '../../data/models/ticket_model.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/usecases/save_ticket_usecase.dart';
import '../../domain/usecases/update_ticket_usecase.dart';

part 'ticket_form_event.dart';
part 'ticket_form_state.dart';

class TicketFormBloc extends Bloc<TicketCreationEvent, TicketCreationState> {
  final SaveTicketUseCase saveTicketUseCase;
  final UpdateTicketUseCase updateTicketUseCase;  

  TicketFormBloc({
    required this.saveTicketUseCase,
    required this.updateTicketUseCase,
  }) : super(TicketCreationInitial()) {
    on<CreateTicketSubmitted>(_onSubmit);
    on<UpdateTicketSubmitted>(_onUpdate);
  }

  Future<void> _onSubmit(
      CreateTicketSubmitted event, Emitter<TicketCreationState> emit) async {
    emit(TicketCreationLoading());

    // 1. Creamos el segmento de ida.
    final outboundSegment = FlightSegmentEntity(
      id: 0,
      ticketId: 0, // El ID se asignará en la capa de datos
      airlineCode: event.segmentAirline,
      flightNumber: event.segmentFlightNumber,
      origin: event.segmentOrigin,
      destination: event.segmentDestination,
      departureDate: event.segmentDepartureTime,
      arrivalDate: event.segmentArrivalTime,
    );

    List<FlightSegmentEntity> segments = [outboundSegment];

    // 2. Si es un viaje de ida y vuelta, creamos y añadimos el segmento de vuelta.
    if (event.returnSegment != null) {
      segments.add(event.returnSegment!);
    }
    
    // 3. Creamos la entidad del boleto principal
    final newTicket = TicketModel( // Usamos TicketModel para facilitar el mapeo en el repo
      id: 0,
      clientId: event.clientId,
      pnr: event.pnr,
      emissionDate: event.emissionDate,
      transportType: TransportType.aereo, // Fijo por ahora
      flightType: event.flightType,
      status: event.status,
      currency: event.currency,
      totalPrice: event.totalPrice,
      commission: event.commission,
      baseFare: event.baseFare,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      segments: segments,
      ticketNumber: event.ticketNumber,
      issuingAgent: event.issuingAgent,
    );

    // 4. Llamamos al caso de uso para guardar el boleto.
    final result = await saveTicketUseCase(newTicket);

    // 5. Emitimos el estado de éxito o fracaso.
    result.fold(
      (failure) => emit(TicketCreationFailure(failure.message)),
      (_) => emit(TicketCreationSuccess()),
    );
  }

  Future<void> _onUpdate(
      UpdateTicketSubmitted event, Emitter<TicketCreationState> emit) async {
    emit(TicketCreationLoading());
    final result = await updateTicketUseCase(event.updatedTicket);
    result.fold(
      (failure) => emit(TicketCreationFailure(failure.message)),
      (_) => emit(TicketCreationSuccess()),
    );
  }
}