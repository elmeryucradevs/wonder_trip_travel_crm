import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/client_entity.dart';

/// ---
/// [IClientRepository] es una interfaz (clase abstracta) que define el contrato
/// para las operaciones de datos relacionadas con los clientes.
///
/// La capa de dominio utiliza esta interfaz para acceder a los datos de los clientes,
/// sin conocer los detalles de implementación (si vienen de una API, una base de datos
/// local, etc.). Esto cumple con el Principio de Inversión de Dependencias (SOLID).
///
/// Cada método devuelve un [Future<Either<Failure, T>>], lo que garantiza un
/// manejo de errores robusto y explícito.
/// ---
abstract class IClientRepository {
  /// ---
  /// Obtiene una lista de todos los clientes.
  ///
  /// Devuelve:
  /// - [Right<List<ClientEntity>>] en caso de éxito.
  /// - [Left<Failure>] si ocurre un error (ej. [ServerFailure], [CacheFailure]).
  /// ---
  Future<Either<Failure, List<ClientEntity>>> getAllClients();

  Future<Either<Failure, void>> saveClient(ClientEntity client);

  //Future<Either<Failure, void>> updateClient(ClientEntity client);
  
  Future<Either<Failure, void>> deleteClient(int id);

  Future<Either<Failure, List<ClientEntity>>> getClientsWithUpcomingBirthdays();

}