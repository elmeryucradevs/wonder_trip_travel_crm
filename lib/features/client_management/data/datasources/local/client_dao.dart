import '../../../../../core/db/database.dart';
import 'package:drift/drift.dart';

// Importa las tablas generadas por Drift desde el archivo de la base de datos.
part 'client_dao.g.dart';

/// ---
/// /// [@DriftAccessor] indica a Drift que genere una implementación para este DAO.
/// ///
/// /// [ClientDao] encapsula todas las consultas a la base de datos relacionadas con la
/// /// tabla [Clients]. Esto mantiene nuestro código de acceso a datos organizado y
/// /// separado de otras lógicas.
/// ///
/// /// Se asocia con la tabla [Tables.clients].
/// ---
@DriftAccessor(tables: [Clients])
class ClientDao extends DatabaseAccessor<AppDatabase> with _$ClientDaoMixin {
  /// /// El constructor requiere una instancia de la base de datos principal [AppDatabase].
  /// /// Drift se encarga de inyectar esta dependencia automáticamente.
  ClientDao(super.db);

  /// ---
  /// /// Obtiene todos los clientes de la base de datos, ordenados por apellido y nombre.
  /// ///
  /// /// Devuelve un [Future<List<Client>>], donde [Client] es la clase de datos
  /// /// generada por Drift a partir de nuestra definición de tabla.
  /// ---
  Future<List<Client>> getAllClients() =>
      (select(clients)..orderBy([
            (t) => OrderingTerm(expression: t.lastName),
            (t) => OrderingTerm(expression: t.name),
          ]))
          .get();

  /// ---
  /// /// Inserta un nuevo cliente en la base de datos.
  /// ///
  /// /// [ClientsCompanion] es una clase generada por Drift que se utiliza para
  /// /// operaciones de escritura (insertar, actualizar) para manejar valores nulos y
  /// /// por defecto de forma segura.
  /// ---
  Future<int> insertClient(ClientsCompanion client) =>
      into(clients).insert(client);

  /// ---
  /// /// Actualiza un cliente existente.
  /// ---
  Future<bool> updateClient(ClientsCompanion client) =>
      update(clients).replace(client);

  /// ---
  /// /// Elimina un cliente por su ID.
  /// ---
  Future<int> deleteClient(int id) =>
      (delete(clients)..where((t) => t.id.equals(id))).go();
}
