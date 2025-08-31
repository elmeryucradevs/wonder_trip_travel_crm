import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/domain/usecases/get_clients_with_upcoming_birthdays_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../ticket_management/domain/entities/ticket_entity.dart';
import '../../domain/usecases/get_recent_clients_usecase.dart';
import '../../domain/usecases/get_upcoming_flights_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetClientsWithUpcomingBirthdaysUseCase
  getClientsWithUpcomingBirthdaysUseCase;
  final GetUpcomingFlightsUseCase getUpcomingFlightsUseCase;
  final GetRecentClientsUseCase getRecentClientsUseCase;

  DashboardBloc({
    required this.getClientsWithUpcomingBirthdaysUseCase,
    required this.getUpcomingFlightsUseCase,
    required this.getRecentClientsUseCase,
  }) : super(DashboardLoading()) {
    on<LoadDashboardData>(_onLoadDashboardData);
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
    ]);

    final birthdayResult = results[0] as Either<Failure, List<ClientEntity>>;
    final upcomingFlightsResult = results[1] as Either<Failure, List<TicketEntity>>;
    final recentClientsResult = results[2] as Either<Failure, List<ClientEntity>>;

// Procesamos todos los resultados. Si alguno falla, emitimos Failure.
    final failures = <Failure>[];
    List<ClientEntity> birthdayClients = [];
    List<TicketEntity> upcomingFlights = [];
    List<ClientEntity> recentClients = [];

    birthdayResult.fold((f) => failures.add(f), (d) => birthdayClients = d);
    upcomingFlightsResult.fold((f) => failures.add(f), (d) => upcomingFlights = d);
    recentClientsResult.fold((f) => failures.add(f), (d) => recentClients = d);

    if (failures.isNotEmpty) {
      emit(DashboardFailure(failures.first.message));
    } else {
      emit(DashboardLoaded(
        birthdayClients: birthdayClients,
        upcomingFlights: upcomingFlights,
        recentClients: recentClients,
      ));
    }
  }
}
