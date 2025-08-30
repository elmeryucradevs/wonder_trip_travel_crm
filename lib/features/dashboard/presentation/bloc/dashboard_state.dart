part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<ClientEntity> birthdayClients;
  // Aquí añadiremos las otras listas (vuelos, etc.) en el futuro

  const DashboardLoaded({required this.birthdayClients});

  @override
  List<Object> get props => [birthdayClients];
}

class DashboardFailure extends DashboardState {
  final String message;
  const DashboardFailure(this.message);
  @override
  List<Object> get props => [message];
}