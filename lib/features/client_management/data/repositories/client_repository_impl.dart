import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/config/injection_container.dart';
import '../../domain/entities/client_entity.dart';
import '../../domain/repositories/i_client_repository.dart';
import '../datasources/client_local_data_source.dart';
import '../models/client_model.dart';

/// ---
/// [ClientRepositoryImpl] es la implementación concreta de [IClientRepository].
///
/// Actúa como un puente entre la capa de dominio y la capa de datos. Su
/// responsabilidad es obtener datos de las fuentes de datos (DataSource),
/// capturar cualquier excepción que ocurra y convertirla en un [Failure]
/// comprensible para la capa de dominio.
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

  @override
  Future<Either<Failure, List<ClientEntity>>> getClientsWithUpcomingBirthdays() async {
    try {
      final clientModels = await localDataSource.getClientsWithUpcomingBirthdays();
      return Right(clientModels);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> getRecentClients() async {
    try {
      final clients = await localDataSource.getRecentClients();
      return Right(clients);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveClient(ClientEntity client) async {
    try {
      // Convertimos la entidad de dominio a un modelo de datos antes de pasarla
      // a la fuente de datos.
      final clientModel = ClientModel(
        id: client.id,
        name: client.name,
        lastName: client.lastName,
        email: client.email,
        phone: client.phone,
        birthDate: client.birthDate,
        documentNumber: client.documentNumber,
        documentType: client.documentType,
        travelerNumber: client.travelerNumber,
        billingName: client.billingName,
        billingDocument: client.billingDocument,
        billingAddress: client.billingAddress,
      );
      // --- LÓGICA DE DECISIÓN ---
      // Si el ID es 0, es un cliente nuevo. Si no, es una actualización.
      if (client.id == 0) {
        await localDataSource.saveClient(clientModel);
      } else {
        await localDataSource.updateClient(clientModel);
      }
      
      return const Right(null);
    } on CacheException catch (e) {
      // ... (manejo de errores sin cambios)
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteClient(int id) async {
    try {
      await localDataSource.deleteClient(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalClients() async {
    try {
      final totalClients = await localDataSource.getTotalClients();
      return Right(totalClients);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}