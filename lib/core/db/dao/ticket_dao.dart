import '../database.dart';
import 'package:drift/drift.dart';

part 'ticket_dao.g.dart';

@DriftAccessor(tables: [Tickets, FlightSegments])
class TicketDao extends DatabaseAccessor<AppDatabase> with _$TicketDaoMixin {
  TicketDao(super.db);

  /// Obtiene todos los boletos asociados a un ID de cliente específico.
  Future<List<Ticket>> getTicketsForClient(int clientId) {
    return (select(tickets)..where((t) => t.clientId.equals(clientId))).get();
  }

  Future<int> insertTicket(TicketsCompanion ticket) => into(tickets).insert(ticket);

  Future<bool> updateTicket(TicketsCompanion ticket) => update(tickets).replace(ticket);
  Future<int> insertFlightSegment(FlightSegmentsCompanion segment) => into(flightSegments).insert(segment);

  Future<void> deleteFlightSegmentsForTicket(int ticketId) {
    return (delete(flightSegments)..where((tbl) => tbl.ticketId.equals(ticketId))).go();
  }
}