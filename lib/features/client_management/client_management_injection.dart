import '../../core/config/injection_container.dart';
import '../../core/db/database.dart';
import 'data/datasources/client_local_data_source.dart';
import 'data/datasources/local/client_dao.dart';
import 'data/repositories/client_repository_impl.dart';
import 'domain/repositories/i_client_repository.dart';
import 'domain/usecases/delete_client_usecase.dart';
import 'domain/usecases/get_all_clients_usecase.dart';
import 'presentation/bloc/client_detail/client_detail_bloc.dart';
import 'presentation/bloc/client_list_bloc.dart';
import 'domain/usecases/save_client_usecase.dart';
import 'presentation/bloc/client_creation/client_creation_bloc.dart';


/// ---
/// /// [initClientManagementFeature] registra todas las dependencias necesarias
/// /// para la funcionalidad de gestión de clientes.
/// ///
/// /// Sigue el patrón de la Arquitectura Limpia:
/// /// 1. Registra el BLoC ([ClientListBloc]) como `factory` porque la UI puede
/// ///    necesitar crear múltiples instancias.
/// /// 2. Registra el Caso de Uso ([GetAllClientsUseCase]) como `lazy singleton`.
/// /// 3. Registra el Repositorio ([ClientRepositoryImpl]) como `lazy singleton`,
/// ///    mapeando la interfaz [IClientRepository] a su implementación.
/// /// 4. Registra la Fuente de Datos ([ClientLocalDataSourceImpl]) como `lazy singleton`.
/// ---
Future<void> initClientManagementFeature() async {
  // BLoC
  sl.registerFactory(() => ClientListBloc(getAllClients: sl()));
  sl.registerFactory(() => ClientCreationBloc(saveClientUseCase: sl()));
  sl.registerFactory(() => ClientDetailBloc(deleteClientUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetAllClientsUseCase(sl()));
  sl.registerLazySingleton(() => SaveClientUseCase(sl()));
  sl.registerLazySingleton(() => DeleteClientUseCase(sl()));

  // Repository
  sl.registerLazySingleton<IClientRepository>(
      () => ClientRepositoryImpl(localDataSource: sl()));

  // Data sources
  // AHORA USAMOS LA BASE DE DATOS REAL
  sl.registerLazySingleton<IClientDataSource>(
      () => ClientLocalDataSourceImpl(clientDao: sl()));

  // --- NUEVAS DEPENDENCIAS DE DRIFT ---

  // Registra una instancia singleton de nuestra base de datos para toda la app.
  sl.registerLazySingleton(() => AppDatabase());

  // Registra el DAO, que depende de la instancia de AppDatabase.
  // GetIt pasará automáticamente la instancia de AppDatabase al constructor del DAO.
  sl.registerLazySingleton(() => ClientDao(sl<AppDatabase>()));
}