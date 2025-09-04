part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
  @override
  List<Object> get props => [];
}

class LoadDashboardData extends DashboardEvent {}

/// Evento para enviar una felicitación de cumpleaños por WhatsApp.
class SendBirthdayGreeting extends DashboardEvent {
  final ClientEntity client;

  const SendBirthdayGreeting(this.client);

  @override
  List<Object> get props => [client];
}

/// Evento para enviar un recordatorio de vuelo por WhatsApp.
class SendFlightReminder extends DashboardEvent {
  final TicketEntity ticket;

  const SendFlightReminder(this.ticket);

  @override
  List<Object> get props => [ticket];
}