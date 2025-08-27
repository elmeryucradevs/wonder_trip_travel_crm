import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/client_entity.dart';
import '../../domain/repositories/i_client_repository.dart';
import '../datasources/client_local_data_source.dart';
import 'package:logger/logger.dart';
import '../../../../core/config/injection_container.dart';

/// ---
/// /// [ClientRepositoryImpl] es la implementación concreta de [IClientRepository].
/// ///
/// /// Actúa como un puente entre la capa de dominio y la capa de datos. Su
/// /// responsabilidad es obtener datos de las fuentes de datos (DataSource),
/// /// capturar cualquier excepción que ocurra y convertirla en un [Failure]
/// /// comprensible para la capa de dominio.
/// ---
class ClientRepositoryImpl implements IClientRepository {
  final IClientDataSource localDataSource;
  final Logger logger = sl<Logger>();

  ClientRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ClientEntity>>> getAllClients() async {
    try {
      final clientModels = await localDataSource.getAllClients();
      // Los modelos de datos se devuelven como entidades de dominio,
      // manteniendo la capa de dominio desacoplada.
      return Right(clientModels);
    } on CacheException catch (e) {
      const errorCode = '[ERROR-CRM001-ClientListFetch]';
      logger.e('$errorCode Error al obtener clientes de caché: ${e.message}');
      return Left(CacheFailure('Error al obtener datos locales: ${e.message}'));
    }
  }
}