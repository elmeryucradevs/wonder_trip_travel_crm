import 'package:drift/drift.dart';
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
    final clientCount =
        await (db.select(db.clients)..limit(1)).getSingleOrNull();

    // Solo si no hay ningún cliente, poblamos la base de datos.
    if (clientCount == null) {
      print('[DB Seeder] Base de datos vacía. Poblando con datos de prueba...');

      // Insertar Clientes
      final mockClientsToSeed = [
        ClientsCompanion(
            name: const Value('Ana'),
            lastName: const Value('García'),
            email: const Value('ana.garcia@email.com')),
        ClientsCompanion(
            name: const Value('Carlos'),
            lastName: const Value('Rodriguez'),
            email: const Value('carlos.r@email.com')),
      ];

      for (var client in mockClientsToSeed) {
        await db.clientDao.insertClient(client);
      }

      // --- BOLETOS DE PRUEBA ---

      // 1. Vuelo de IDA con ESCALA (para Ana García, ID 1)
      var ticketId1 = await db.ticketDao.insertTicket(
        TicketsCompanion(
          clientId: const Value(1),
          pnr: const Value('RDN4LF'),
          totalPrice: const Value(345.50),
          emissionDate: Value(DateTime(2025, 9, 20)),
          flightType: const Value('OW'), // One-Way
          issuingAgent: const Value('Amadeus'),
          passengerCategory: const Value('ADT'),
        ),
      );
      await db.ticketDao.insertFlightSegment(FlightSegmentsCompanion(
        ticketId: Value(ticketId1),
        airlineCode: const Value('AV'),
        flightNumber: const Value('738'),
        origin: const Value('VVI'),
        destination: const Value('MIA'),
        departureDate: Value(DateTime(2025, 10, 15, 07, 30)),
        arrivalDate: Value(DateTime(2025, 10, 15, 17, 00)),
        stopover: const Value('BOG'), // Con escala en Bogotá
      ));

      // 2. Vuelo de IDA SIN ESCALA (para Ana García, ID 1)
      var ticketId2 = await db.ticketDao.insertTicket(
        TicketsCompanion(
          clientId: const Value(1),
          pnr: const Value('BKV89P'),
          totalPrice: const Value(120.00),
          emissionDate: Value(DateTime(2025, 10, 5)),
          flightType: const Value('OW'),
          issuingAgent: const Value('Kiwi'),
          passengerCategory: const Value('ADT'),
        ),
      );
      await db.ticketDao.insertFlightSegment(FlightSegmentsCompanion(
        ticketId: Value(ticketId2),
        airlineCode: const Value('OB'),
        flightNumber: const Value('622'),
        origin: const Value('VVI'),
        destination: const Value('CBB'),
        departureDate: Value(DateTime(2025, 11, 20, 10, 00)),
        arrivalDate: Value(DateTime(2025, 11, 20, 10, 50)),
        // Sin escala
      ));

      // 3. Vuelo IDA Y VUELTA SIN ESCALAS (para Carlos Rodriguez, ID 2)
      var ticketId3 = await db.ticketDao.insertTicket(
        TicketsCompanion(
          clientId: const Value(2),
          pnr: const Value('XYZ789'),
          totalPrice: const Value(250.00),
          emissionDate: Value(DateTime(2025, 11, 1)),
          flightType: const Value('RT'), // Round-Trip
           issuingAgent: const Value('Lufthansa'),
          passengerCategory: const Value('CHD'),
        ),
      );
      // Segmento de Ida
      await db.ticketDao.insertFlightSegment(FlightSegmentsCompanion(
        ticketId: Value(ticketId3),
        airlineCode: const Value('Z8'),
        flightNumber: const Value('410'),
        origin: const Value('SRE'),
        destination: const Value('VVI'),
        departureDate: Value(DateTime(2025, 12, 1, 08, 00)),
        arrivalDate: Value(DateTime(2025, 12, 1, 08, 45)),
      ));
      // Segmento de Vuelta
      await db.ticketDao.insertFlightSegment(FlightSegmentsCompanion(
        ticketId: Value(ticketId3),
        airlineCode: const Value('Z8'),
        flightNumber: const Value('411'),
        origin: const Value('VVI'),
        destination: const Value('SRE'),
        departureDate: Value(DateTime(2025, 12, 10, 18, 30)),
        arrivalDate: Value(DateTime(2025, 12, 10, 19, 15)),
      ));

      // 4. Vuelo IDA Y VUELTA CON ESCALA EN LA IDA (para Carlos Rodriguez, ID 2)
      var ticketId4 = await db.ticketDao.insertTicket(
        TicketsCompanion(
          clientId: const Value(2),
          pnr: const Value('ABC123'),
          totalPrice: const Value(980.70),
          emissionDate: Value(DateTime(2025, 11, 5)),
          flightType: const Value('RT'),
          issuingAgent: const Value('Expedia'),
          passengerCategory: const Value('ADT'),
        ),
      );
      // Segmento de Ida (con escala)
      await db.ticketDao.insertFlightSegment(FlightSegmentsCompanion(
        ticketId: Value(ticketId4),
        airlineCode: const Value('CM'),
        flightNumber: const Value('150'),
        origin: const Value('VVI'),
        destination: const Value('MEX'),
        departureDate: Value(DateTime(2026, 1, 10, 06, 00)),
        arrivalDate: Value(DateTime(2026, 1, 10, 15, 00)),
        stopover: const Value('PTY'),
      ));
      // Segmento de Vuelta (directo)
      await db.ticketDao.insertFlightSegment(FlightSegmentsCompanion(
        ticketId: Value(ticketId4),
        airlineCode: const Value('CM'),
        flightNumber: const Value('151'),
        origin: const Value('MEX'),
        destination: const Value('VVI'),
        departureDate: Value(DateTime(2026, 1, 25, 18, 00)),
        arrivalDate: Value(DateTime(2026, 1, 26, 03, 00)),
      ));

      print('[DB Seeder] Datos de prueba insertados.');
    }
  }
}