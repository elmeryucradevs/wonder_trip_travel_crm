import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/domain/usecases/get_clients_with_upcoming_birthdays_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../client_management/domain/usecases/get_total_clients_usecase.dart';
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


  DashboardBloc({
    required this.getClientsWithUpcomingBirthdaysUseCase,
    required this.getUpcomingFlightsUseCase,
    required this.getRecentClientsUseCase,
    required this.getTotalClientsUseCase,
    required this.getTotalTicketsUseCase,
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
}
