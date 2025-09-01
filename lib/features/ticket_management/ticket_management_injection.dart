import '../../core/config/injection_container.dart';
import 'data/datasources/ticket_local_data_source.dart';
import 'data/repositories/ticket_repository_impl.dart';
import 'domain/repositories/i_ticket_repository.dart';
import 'domain/usecases/delete_ticket_usecase.dart';
import 'domain/usecases/get_tickets_for_client_usecase.dart';
import 'domain/usecases/get_total_tickets_usecase.dart';
import 'domain/usecases/save_ticket_usecase.dart';
import 'domain/usecases/update_ticket_usecase.dart';
import 'presentation/bloc/ticket_detail_bloc.dart';
import 'presentation/bloc/ticket_form_bloc.dart';
import 'presentation/bloc/ticket_list_bloc.dart';

Future<void> initTicketManagementFeature() async {
  // BLoC
  sl.registerFactory(() => TicketListBloc(getTicketsForClientUseCase: sl()));
  sl.registerFactory(() => TicketFormBloc(
      saveTicketUseCase: sl(),
      updateTicketUseCase: sl(),
    )); 
  sl.registerFactory(() => TicketDetailBloc(deleteTicketUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTicketsForClientUseCase(sl()));
  sl.registerLazySingleton(() => SaveTicketUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTicketUseCase(sl())); 
  sl.registerLazySingleton(() => DeleteTicketUseCase(sl()));
  sl.registerLazySingleton(() => GetTotalTicketsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ITicketRepository>(
      () => TicketRepositoryImpl(localDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ITicketDataSource>(
      () => TicketLocalDataSourceImpl(ticketDao: sl()));
}