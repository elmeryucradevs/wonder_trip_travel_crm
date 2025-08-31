// lib/features/dashboard/dashboard_injection.dart
import 'package:wonder_trip_travel_crm/core/config/injection_container.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/domain/usecases/get_clients_with_upcoming_birthdays_usecase.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/presentation/bloc/dashboard_bloc.dart';

import 'domain/usecases/get_recent_clients_usecase.dart';
import 'domain/usecases/get_upcoming_flights_usecase.dart';

Future<void> initDashboardFeature() async {
  // BLoC
  sl.registerFactory(
    () => DashboardBloc(
      getClientsWithUpcomingBirthdaysUseCase: sl(), 
      getUpcomingFlightsUseCase: sl(),
      getRecentClientsUseCase: sl(), ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetRecentClientsUseCase(sl()));
  sl.registerLazySingleton(() => GetClientsWithUpcomingBirthdaysUseCase(sl()));
  sl.registerLazySingleton(() => GetUpcomingFlightsUseCase(sl()));

}