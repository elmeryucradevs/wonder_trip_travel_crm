import 'package:drift/drift.dart';
import 'package:wonder_trip_travel_crm/core/db/dao/ticket_dao.dart';
import 'database.dart';

/// ---
/// /// [DbSeeder] es una clase de utilidad para poblar la base de datos con
/// /// datos iniciales si está vacía.
/// ///
/// /// Esto centraliza la lógica de "seeding" y evita dependencias cruzadas
/// /// entre las diferentes fuentes de datos (DataSources).
/// ---
class DbSeeder {
  final AppDatabase db;

  DbSeeder(this.db);

  /// /// [seedDatabase] comprueba si existen clientes y, si no, inserta
  /// /// un conjunto de datos de prueba para clientes y boletos.
  Future<void> seedDatabase() async {
    final clientCount = await (db.select(db.clients)..limit(1)).getSingleOrNull();

    // Solo si no hay ningún cliente, poblamos la base de datos.
    if (clientCount == null) {
      print('[DB Seeder] Base de datos vacía. Poblando con datos de prueba...');

      // Insertar Clientes
      final mockClientsToSeed = [
        ClientsCompanion(name: const Value('Ana'), lastName: const Value('García'), email: const Value('ana.garcia@email.com')),
        ClientsCompanion(name: const Value('Carlos'), lastName: const Value('Rodriguez'), email: const Value('carlos.r@email.com')),
      ];

      for (var client in mockClientsToSeed) {
        await db.clientDao.insertClient(client);
      }

      // Insertar Boletos para el primer cliente (ID será 1)
      await db.ticketDao.insertTicket(
        TicketsCompanion(
          clientId: const Value(1), // ID de Ana García
          pnr: const Value('RDN4LF'),
          totalPrice: const Value(345.50),
          emissionDate: Value(DateTime(2025, 9, 20)),
        ),
      );
      await db.ticketDao.insertTicket(
        TicketsCompanion(
          clientId: const Value(1), // ID de Ana García
          pnr: const Value('BKV89P'),
          totalPrice: const Value(120.00),
          emissionDate: Value(DateTime(2025, 10, 5)),
        ),
      );
      
      print('[DB Seeder] Datos de prueba insertados.');
    }
  }
}