import '../database.dart';
import 'package:drift/drift.dart';

import 'upcoming_flight.dart';

part 'ticket_dao.g.dart';

@DriftAccessor(tables: [Tickets, FlightSegments])
class TicketDao extends DatabaseAccessor<AppDatabase> with _$TicketDaoMixin {
  TicketDao(super.db);

  /// Obtiene todos los boletos asociados a un ID de cliente específico.
  Future<List<Ticket>> getTicketsForClient(int clientId) {
    return (select(tickets)..where((t) => t.clientId.equals(clientId))).get();
  }

  Future<List<FlightSegment>> getFlightSegmentsForTicket(int ticketId) {
    return (select(flightSegments)..where((s) => s.ticketId.equals(ticketId))).get();
  }

  Future<int> insertTicket(TicketsCompanion ticket) => into(tickets).insert(ticket);

  Future<bool> updateTicket(TicketsCompanion ticket) => update(tickets).replace(ticket);
  
  Future<int> insertFlightSegment(FlightSegmentsCompanion segment) => into(flightSegments).insert(segment);

  Future<void> deleteFlightSegmentsForTicket(int ticketId) {
    return (delete(flightSegments)..where((tbl) => tbl.ticketId.equals(ticketId))).go();
  }

  Future<void> deleteTicketAndSegments(int ticketId) {
    return transaction(() async {
      await deleteFlightSegmentsForTicket(ticketId);
      await (delete(tickets)..where((tbl) => tbl.id.equals(ticketId))).go();
    });
  }
  /// ---
  /// Obtiene una lista de los próximos segmentos de vuelo.
  ///
  /// Busca segmentos cuya fecha de salida sea posterior a la actual y los
  /// ordena por la fecha de salida más cercana. Opcionalmente, se puede
  /// limitar el número de resultados.
  /// ---
  Future<List<FlightSegment>> getUpcomingFlights({int limit = 5}) {
    final now = DateTime.now();
    return (select(flightSegments)
          ..where((s) => s.departureDate.isBiggerThanValue(now))
          ..orderBy([(s) => OrderingTerm(expression: s.departureDate)])
          ..limit(limit))
        .get();
  }

  /// ---
  /// Obtiene los próximos segmentos de vuelo junto con la información del
  /// boleto y del cliente asociado.
  ///
  /// Realiza un JOIN entre las tres tablas para obtener todos los datos
  /// necesarios en una sola consulta eficiente.
  /// ---
  Future<List<UpcomingFlight>> getUpcomingFlightDetails({int limit = 5}) {
    final now = DateTime.now();

    // La consulta une las tablas usando `join`
    final query = select(flightSegments).join([
      innerJoin(tickets, tickets.id.equalsExp(flightSegments.ticketId)),
      innerJoin(clients, clients.id.equalsExp(tickets.clientId)),
    ])
    ..where(flightSegments.departureDate.isBiggerThanValue(now))
    ..orderBy([OrderingTerm.asc(flightSegments.departureDate)])
    ..limit(limit);

    // Mapeamos el resultado a una clase de datos personalizada
    return query.map((row) {
      return UpcomingFlight(
        segment: row.readTable(flightSegments),
        ticket: row.readTable(tickets),
        client: row.readTable(clients),
      );
    }).get();
  }

  /// Cuenta el número total de boletos en la base de datos.
  Expression<int> countTickets() => tickets.id.count();

  Future<int> getTotalTickets() async {
    final countExp = countTickets();
    final query = selectOnly(tickets)..addColumns([countExp]);
    return (await query.map((row) => row.read(countExp)).getSingle()) ?? 0;
  }
}