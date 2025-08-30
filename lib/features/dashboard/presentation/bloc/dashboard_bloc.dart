import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/domain/usecases/get_clients_with_upcoming_birthdays_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetClientsWithUpcomingBirthdaysUseCase getClientsWithUpcomingBirthdaysUseCase;

  DashboardBloc({required this.getClientsWithUpcomingBirthdaysUseCase}) : super(DashboardLoading()) {
    on<LoadDashboardData>(_onLoadDashboardData);
  }

  Future<void> _onLoadDashboardData(
      LoadDashboardData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());

    final birthdayResult = await getClientsWithUpcomingBirthdaysUseCase(null);

    // Usamos `either.fold()` para manejar el éxito o el fracaso
    birthdayResult.fold(
      (failure) => emit(DashboardFailure(failure.message)),
      (clients) => emit(DashboardLoaded(birthdayClients: clients)),
    );
  }
}