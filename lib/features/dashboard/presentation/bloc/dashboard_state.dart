part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<ClientEntity> birthdayClients;
  final List<TicketEntity> upcomingFlights;
  final List<ClientEntity> recentClients;
  
  // Aquí añadiremos las otras listas (vuelos, etc.) en el futuro

  const DashboardLoaded({
    required this.birthdayClients,
    required this.upcomingFlights,
    required this.recentClients,
  });

  @override
  List<Object> get props => [birthdayClients, upcomingFlights, recentClients];
}

class DashboardFailure extends DashboardState {
  final String message;
  const DashboardFailure(this.message);
  @override
  List<Object> get props => [message];
}
