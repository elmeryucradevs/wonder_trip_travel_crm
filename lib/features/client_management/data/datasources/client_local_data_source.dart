import '../../../../core/db/database.dart';
import '../models/client_model.dart';
import 'local/client_dao.dart';
import 'package:drift/drift.dart' as drift;

abstract class IClientDataSource {
  Future<List<ClientModel>> getAllClients();
  Future<void> saveClient(ClientModel client);
}

/// ---
/// /// [ClientLocalDataSourceImpl] ahora depende del [ClientDao] para interactuar
/// /// con la base de datos. La dependencia es inyectada por GetIt.
/// ///
/// /// Se ha añadido una lógica de "seeding" para poblar la base de datos con
/// /// datos iniciales si está vacía, para facilitar el desarrollo.
/// ---
class ClientLocalDataSourceImpl implements IClientDataSource {
  final ClientDao clientDao;

  ClientLocalDataSourceImpl({required this.clientDao}) {
    _seedDatabaseIfEmpty();
  }

  /// ---
  /// Obtiene los clientes desde la base de datos real usando el DAO.
  ///
  /// 1. Llama a `clientDao.getAllClients()` que devuelve `Future<List<Client>>`.
  /// 2. Mapea la lista de `Client` (objeto de Drift) a una lista de `ClientModel`
  ///    (nuestro DTO de la capa de datos). Esto mantiene la separación de
  ///    responsabilidades.
  /// ---
  @override
  Future<List<ClientModel>> getAllClients() async {
    final clientListFromDb = await clientDao.getAllClients();
    return clientListFromDb
        .map((client) => ClientModel(
              id: client.id,
              name: client.name,
              lastName: client.lastName,
              email: client.email,
              phone: client.phone,
              birthDate: client.birthDate,
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
      name: drift.Value(client.name),
      lastName: drift.Value(client.lastName),
      email: drift.Value(client.email),
      phone: drift.Value(client.phone),
      birthDate: drift.Value(client.birthDate),
    );
    await clientDao.insertClient(clientCompanion);
  }

  /// ---
  /// [seedDatabaseIfEmpty] es un método auxiliar para poblar la base de datos
  /// con datos de prueba la primera vez que se ejecuta la aplicación.
  ///
  /// Comprueba si ya existen clientes. Si no, inserta una lista predefinida.
  /// Esto evita tener una pantalla vacía al principio del desarrollo.
  /// ---
  void _seedDatabaseIfEmpty() async {
    final clients = await getAllClients();
    if (clients.isEmpty) {
      final mockClientsToSeed = [
        ClientsCompanion(name: const drift.Value('Ana'), lastName: const drift.Value('García'), email: const drift.Value('ana.garcia@email.com'), phone: const drift.Value('123456789'), birthDate: drift.Value(DateTime(1990, 5, 15))),
        ClientsCompanion(name: const drift.Value('Carlos'), lastName: const drift.Value('Rodriguez'), email: const drift.Value('carlos.r@email.com'), phone: const drift.Value('987654321'), birthDate: drift.Value(DateTime(1985, 8, 22))),
        ClientsCompanion(name: const drift.Value('Lucía'), lastName: const drift.Value('Martinez'), email: const drift.Value('lucia.m@email.com')),
        ClientsCompanion(name: const drift.Value('Javier'), lastName: const drift.Value('Sánchez'), email: const drift.Value('javier.s@email.com'), phone: const drift.Value('555123456'), birthDate: drift.Value(DateTime(1992, 2, 10))),
        ClientsCompanion(name: const drift.Value('Elena'), lastName: const drift.Value('Pérez'), email: const drift.Value('elena.p@email.com'), birthDate: drift.Value(DateTime(2000, 11, 30))),
      ];

      for (var client in mockClientsToSeed) {
        await clientDao.insertClient(client);
      }
    }
  }
}