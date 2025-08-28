import '../../core/config/injection_container.dart';
import 'data/datasources/ticket_local_data_source.dart';
import 'data/repositories/ticket_repository_impl.dart';
import 'domain/repositories/i_ticket_repository.dart';
import 'domain/usecases/get_tickets_for_client_usecase.dart';
import 'domain/usecases/save_ticket_usecase.dart';
import 'presentation/bloc/ticket_creation_bloc.dart';
import 'presentation/bloc/ticket_list_bloc.dart';

Future<void> initTicketManagementFeature() async {
  // BLoC
  sl.registerFactory(() => TicketListBloc(getTicketsForClientUseCase: sl()));
  sl.registerFactory(() => TicketCreationBloc(saveTicketUseCase: sl())); 

  // Use cases
  sl.registerLazySingleton(() => GetTicketsForClientUseCase(sl()));
  sl.registerLazySingleton(() => SaveTicketUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ITicketRepository>(
      () => TicketRepositoryImpl(localDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ITicketDataSource>(
      () => TicketLocalDataSourceImpl(ticketDao: sl()));
}