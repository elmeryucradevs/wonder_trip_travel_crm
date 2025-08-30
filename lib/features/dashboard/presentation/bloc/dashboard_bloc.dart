import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/domain/usecases/get_clients_with_upcoming_birthdays_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../ticket_management/domain/entities/ticket_entity.dart';
import '../../domain/usecases/get_upcoming_flights_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetClientsWithUpcomingBirthdaysUseCase getClientsWithUpcomingBirthdaysUseCase;
  final GetUpcomingFlightsUseCase getUpcomingFlightsUseCase;

  DashboardBloc({
    required this.getClientsWithUpcomingBirthdaysUseCase, 
    required this.getUpcomingFlightsUseCase,
  }) : super(DashboardLoading()) {
    on<LoadDashboardData>(_onLoadDashboardData);
  }

  Future<void> _onLoadDashboardData(
      LoadDashboardData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());

    // Cargamos ambos datos en paralelo
    final results = await Future.wait([
      getClientsWithUpcomingBirthdaysUseCase(null),
      getUpcomingFlightsUseCase(null),
    ]);

    final birthdayResult = await getClientsWithUpcomingBirthdaysUseCase(null);
    final flightsResult = results[1] as Either<Failure, List<TicketEntity>>;

    // Usamos `either.fold()` para manejar el éxito o el fracaso
    birthdayResult.fold(
      (failure) => emit(DashboardFailure(failure.message)),
      (clients) {
        flightsResult.fold(
          (failure) => emit(DashboardFailure(failure.message)),
          (tickets) => emit(DashboardLoaded(
            birthdayClients: clients,
            upcomingFlights: tickets,
          )),
        );
      },
    );
  }
}