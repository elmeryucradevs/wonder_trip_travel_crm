import 'package:drift/drift.dart';

import '../../../../core/config/injection_container.dart';
import '../../../../core/db/dao/ticket_dao.dart';
import 'local/client_dao.dart';
import '../models/client_model.dart';
import '../../../../core/db/database.dart';
import '../../../../core/error/exceptions.dart';


abstract class IClientDataSource {
  Future<List<ClientModel>> getAllClients();
  Future<List<ClientModel>> getClientsWithUpcomingBirthdays();
  Future<void> saveClient(ClientModel client);
  Future<void> updateClient(ClientModel client);
  Future<void> deleteClient(int id);
}

/// ---
/// [ClientLocalDataSourceImpl] ahora depende del [ClientDao] para interactuar
/// con la base de datos. La dependencia es inyectada por GetIt.
///
/// Se ha añadido una lógica de "seeding" para poblar la base de datos con
/// datos iniciales si está vacía, para facilitar el desarrollo.
/// ---
class ClientLocalDataSourceImpl implements IClientDataSource {
  final ClientDao clientDao;

  final TicketDao ticketDao = sl<TicketDao>();

  ClientLocalDataSourceImpl({required this.clientDao});

  /// ---
  /// Obtiene los clientes desde la base de datos real usando el DAO.
  ///
  /// 1. Llama a `clientDao.getAllClients()` que devuelve `Future<List<Client>>`.
  /// 2. Mapea la lista de `Client` (objeto de Drift) a una lista de `ClientModel`
  ///    (nuestro DTO de la capa de datos). Esto mantiene la separación de
  ///    responsabilidades.
  /// ---
  /// 
  @override
  Future<List<ClientModel>> getAllClients() async {
    final clientListFromDb = await clientDao.getAllClients();
    // Mapeamos los nuevos campos
    return clientListFromDb
        .map((client) => ClientModel(
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
            ))
        .toList();
  }

  @override
  Future<List<ClientModel>> getClientsWithUpcomingBirthdays() async {
    final clientListFromDb = await clientDao.getClientsOrderedByNextBirthday();
    return clientListFromDb
        .map((client) => ClientModel(
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
            ))
        .toList();
  }

  /// ---
  /// Implementación para guardar un nuevo cliente en la base de datos.
  ///
  /// Convierte el [ClientModel] a un [ClientsCompanion] de Drift para la inserción.
  /// El ID se deja como ausente (`drift.Value.absent()`) para que la base de datos
  /// lo autogenere.
  /// ---
  @override
  Future<void> saveClient(ClientModel client) async {
    final clientCompanion = ClientsCompanion(
      name: Value(client.name),
      lastName: Value(client.lastName),
      email: Value(client.email),
      phone: Value(client.phone),
      birthDate: Value(client.birthDate),
      documentNumber: Value(client.documentNumber),
      documentType: Value(client.documentType),
      travelerNumber: Value(client.travelerNumber),
      billingName: Value(client.billingName),
      billingDocument: Value(client.billingDocument),
      billingAddress: Value(client.billingAddress),
    );

    // Envolvemos la llamada a la base de datos en un bloque try-catch.
    try {
      await clientDao.insertClient(clientCompanion);
    } catch (e) { // Atrapamos cualquier excepción 'e'.
      // Convertimos el error a texto para poder analizarlo.
      final errorString = e.toString();

      // Buscamos el texto del error en lugar del tipo.
      if (errorString.contains('UNIQUE constraint failed')) {
        if (errorString.contains('documentNumber')) {
          throw CacheException('El número de documento ya está registrado.');
        } else if (errorString.contains('travelerNumber')) {
          throw CacheException('El código de viajero frecuente ya está registrado.');
        } else {
          // Mensaje genérico si no podemos identificar el campo exacto
          throw CacheException('Uno de los campos únicos ya está en uso.');
        }
      }
      
      // Si no es un error de unicidad, lanzamos un error genérico.
      throw CacheException('Error de base de datos: $errorString');
    }
  
  }

  @override
  Future<void> updateClient(ClientModel client) async {
    final clientCompanion = ClientsCompanion(
      id: Value(client.id), // ¡Importante! Pasamos el ID para la actualización.
      name: Value(client.name),
      lastName: Value(client.lastName),
      email: Value(client.email),
      phone: Value(client.phone),
      birthDate: Value(client.birthDate),
      documentNumber: Value(client.documentNumber),
      documentType: Value(client.documentType),
      travelerNumber: Value(client.travelerNumber),
      billingName: Value(client.billingName),
      billingDocument: Value(client.billingDocument),
      billingAddress: Value(client.billingAddress),
    );
    // Usamos el método de actualización del DAO
    await clientDao.updateClient(clientCompanion); 
  }

  @override
  Future<void> deleteClient(int id) async {
    try {
      await clientDao.deleteClient(id);
    } catch (e) { // <-- Atrapamos cualquier excepción 'e'
      // Convertimos el error a texto y lo lanzamos como nuestra excepción de caché
      throw CacheException('Error al eliminar el cliente: ${e.toString()}');
    }
  }

}