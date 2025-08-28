import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/flight_segment_entity.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/usecases/save_ticket_usecase.dart';

part 'ticket_creation_event.dart';
part 'ticket_creation_state.dart';

class TicketCreationBloc extends Bloc<TicketCreationEvent, TicketCreationState> {
  final SaveTicketUseCase saveTicketUseCase;

  TicketCreationBloc({required this.saveTicketUseCase}) : super(TicketCreationInitial()) {
    on<CreateTicketSubmitted>(_onSubmit);
  }

  Future<void> _onSubmit(
      CreateTicketSubmitted event, Emitter<TicketCreationState> emit) async {
    emit(TicketCreationLoading());

    final segment = FlightSegmentEntity(
      id: 0,
      ticketId: 0,
      airlineCode: event.segmentAirline,
      flightNumber: event.segmentFlightNumber,
      origin: event.segmentOrigin,
      destination: event.segmentDestination,
      departureDate: event.segmentDepartureTime,
      arrivalDate: event.segmentArrivalTime,
    );

    final newTicket = TicketEntity(
      id: 0,
      clientId: event.clientId,
      pnr: event.pnr,
      emissionDate: event.emissionDate,
      transportType: TransportType.aereo, // Por ahora, fijo
      totalPrice: event.totalPrice,
      commission: event.commission,
      baseFare: event.baseFare,
      currency: event.currency,
      status: event.status,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      segments: [segment],
    );

    final result = await saveTicketUseCase(newTicket);

    result.fold(
      (failure) => emit(TicketCreationFailure(failure.message)),
      (_) => emit(TicketCreationSuccess()),
    );
  }
}