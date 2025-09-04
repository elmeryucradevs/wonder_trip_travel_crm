import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/domain/usecases/get_clients_with_upcoming_birthdays_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../client_management/domain/usecases/get_total_clients_usecase.dart';
import '../../../client_management/domain/usecases/open_whatsapp_chat_usecase.dart';
import '../../../ticket_management/domain/entities/ticket_entity.dart';
import '../../../ticket_management/domain/usecases/get_total_tickets_usecase.dart';
import '../../domain/usecases/get_recent_clients_usecase.dart';
import '../../domain/usecases/get_upcoming_flights_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetClientsWithUpcomingBirthdaysUseCase
  getClientsWithUpcomingBirthdaysUseCase;
  final GetUpcomingFlightsUseCase getUpcomingFlightsUseCase;
  final GetRecentClientsUseCase getRecentClientsUseCase;
  final GetTotalClientsUseCase getTotalClientsUseCase;
  final GetTotalTicketsUseCase getTotalTicketsUseCase;
  final OpenWhatsAppChatUseCase _openWhatsAppChatUseCase;


  DashboardBloc({
    required this.getClientsWithUpcomingBirthdaysUseCase,
    required this.getUpcomingFlightsUseCase,
    required this.getRecentClientsUseCase,
    required this.getTotalClientsUseCase,
    required this.getTotalTicketsUseCase,
    required OpenWhatsAppChatUseCase openWhatsAppChatUseCase,
  }) :  _openWhatsAppChatUseCase = openWhatsAppChatUseCase,
        super(DashboardLoading()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<SendBirthdayGreeting>(_onSendBirthdayGreeting);
    on<SendFlightReminder>(_onSendFlightReminder); 
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    // Cargamos ambos datos en paralelo
    final results = await Future.wait([
      getClientsWithUpcomingBirthdaysUseCase(null),
      getUpcomingFlightsUseCase(null),
      getRecentClientsUseCase(null), 
      getTotalClientsUseCase(null),
      getTotalTicketsUseCase(null),
    ]);

    final birthdayResult = results[0] as Either<Failure, List<ClientEntity>>;
    final upcomingFlightsResult = results[1] as Either<Failure, List<TicketEntity>>;
    final recentClientsResult = results[2] as Either<Failure, List<ClientEntity>>;
    final totalClientsResult = results[3] as Either<Failure, int>; 
    final totalTicketsResult = results[4] as Either<Failure, int>; 


    // Procesamos todos los resultados. Si alguno falla, emitimos Failure.
    final failures = <Failure>[];
    List<ClientEntity> birthdayClients = [];
    List<TicketEntity> upcomingFlights = [];
    List<ClientEntity> recentClients = [];
    int totalClients = 0;
    int totalTickets = 0;



    birthdayResult.fold((f) => failures.add(f), (d) => birthdayClients = d);
    upcomingFlightsResult.fold((f) => failures.add(f), (d) => upcomingFlights = d);
    recentClientsResult.fold((f) => failures.add(f), (d) => recentClients = d);
    totalClientsResult.fold((f) => failures.add(f), (d) => totalClients = d);
    totalTicketsResult.fold((f) => failures.add(f), (d) => totalTickets = d);


    if (failures.isNotEmpty) {
      emit(DashboardFailure(failures.first.message));
    } else {
      emit(DashboardLoaded(
        birthdayClients: birthdayClients,
        upcomingFlights: upcomingFlights,
        recentClients: recentClients,
        totalClients: totalClients,
        totalTickets: totalTickets,
      ));
    }
  }
  Future<void> _onSendBirthdayGreeting(
    SendBirthdayGreeting event,
    Emitter<DashboardState> emit,
  ) async {
    if (event.client.phone == null) return;
    final message = '''🎉🎂 ¡Hola ${event.client.name}! 🎂🎉
El equipo de *Wonder Trip Travel* te desea un muy feliz cumpleaños. 🥳
Que tengas un día increíble lleno de alegría y nuevas aventuras. ¡Esperamos ser parte de tu próximo gran viaje! ✈️🌍
Saludos cordiales.''';

    await _openWhatsAppChatUseCase(
      OpenWhatsAppChatParams(
        phoneNumber: event.client.phone!,
        message: message,
      ),
    );
  }
  /// Manejador para enviar un recordatorio de vuelo.
  Future<void> _onSendFlightReminder(
    SendFlightReminder event,
    Emitter<DashboardState> emit,
  ) async {
    final ticket = event.ticket;
    final client = ticket.client;

    if (client == null || client.phone == null || client.phone!.isEmpty) return;
    
    final messageBuffer = StringBuffer();
    messageBuffer.writeln('✈️ Hola ${client.name}, ¡tu viaje se acerca!');
    messageBuffer.writeln('Te enviamos un recordatorio de tu próximo vuelo operado por *Wonder Trip Travel*:');


    if (ticket.flightType == 'RT' && ticket.segments.length > 1) {
       messageBuffer.writeln('\n*--- VUELO DE IDA ---*');
    }
    
    // Segmento de ida (o único segmento)
    final firstSegment = ticket.segments.first;
    final formattedDate = DateFormat.yMMMMd('es').format(firstSegment.departureDate);
    final formattedTime = DateFormat.Hm().format(firstSegment.departureDate);

    messageBuffer.writeln('- 🛫 **Origen:** ${firstSegment.origin}');
    messageBuffer.writeln('- 🛬 **Destino:** ${firstSegment.destination}');
    messageBuffer.writeln('- 📅 **Fecha:** $formattedDate');
    messageBuffer.writeln('- ⏰ **Hora de Salida:** $formattedTime');
    messageBuffer.writeln('- **Aerolínea:** ${firstSegment.airlineCode}');
    messageBuffer.writeln('- 🎫 **Nº de Boleto:** ${ticket.ticketNumber}');

    // Segmento de vuelta (si existe)
    if (ticket.flightType == 'RT' && ticket.segments.length > 1) {
      final returnSegment = ticket.segments[1];
      final returnFormattedDate = DateFormat.yMMMMd('es').format(returnSegment.departureDate);
      final returnFormattedTime = DateFormat.Hm().format(returnSegment.departureDate);
      messageBuffer.writeln('\n*--- VUELO DE VUELTA ---*');
      messageBuffer.writeln('- 🛫 **Origen:** ${returnSegment.origin}');
      messageBuffer.writeln('- 🛬 **Destino:** ${returnSegment.destination}');
      messageBuffer.writeln('- 📅 **Fecha:** $returnFormattedDate');
      messageBuffer.writeln('- ⏰ **Hora de Salida:** $returnFormattedTime');
      messageBuffer.writeln('- **Aerolínea:** ${returnSegment.airlineCode}');

    }

    messageBuffer.writeln('\n¡Te deseamos un excelente y puntual viaje!');


    await _openWhatsAppChatUseCase(
      OpenWhatsAppChatParams(
        phoneNumber: client.phone!,
        message: messageBuffer.toString(),
      ),
    );
  }
}