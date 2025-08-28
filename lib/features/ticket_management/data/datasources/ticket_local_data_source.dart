import 'package:drift/drift.dart';

import '../../../../core/db/dao/ticket_dao.dart';
import '../../../../core/db/database.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/ticket_entity.dart';
import '../models/ticket_model.dart';

abstract class ITicketDataSource {
  Future<List<TicketModel>> getTicketsForClient(int clientId);
  Future<void> saveTicket(TicketModel ticket);
  Future<void> updateTicket(TicketModel ticket);
}

class TicketLocalDataSourceImpl implements ITicketDataSource {
  final TicketDao ticketDao;

  TicketLocalDataSourceImpl({required this.ticketDao});

  @override
  Future<List<TicketModel>> getTicketsForClient(int clientId) async {
    try {
      final ticketsFromDb = await ticketDao.getTicketsForClient(clientId);
      return ticketsFromDb
          .map((ticket) => TicketModel(
                id: ticket.id,
                clientId: ticket.clientId,
                pnr: ticket.pnr,
                emissionDate: ticket.emissionDate,
                transportType: ticket.transportType == 'TERRESTRE' ? TransportType.terrestre : TransportType.aereo,
                ticketNumber: ticket.ticketNumber,
                flightType: ticket.flightType,
                passengerCategory: ticket.passengerCategory,
                issuingAgent: ticket.issuingAgent,
                status: ticket.status,
                baseFare: ticket.baseFare,
                currency: ticket.currency,
                taxBO: ticket.taxBO,
                taxA7: ticket.taxA7,
                taxQM: ticket.taxQM,
                taxOM: ticket.taxOM,
                otherTaxes: ticket.otherTaxes,
                totalPrice: ticket.totalPrice,
                commission: ticket.commission,
                originalTicketId: ticket.originalTicketId,
                createdAt: ticket.createdAt,
                updatedAt: ticket.updatedAt,
              ))
          .toList();
    } catch (e) {
      throw CacheException('Error al obtener los boletos de la base de datos.');
    }
  }
  
  @override
  Future<void> saveTicket(TicketModel ticket) async {
    try {
      // Drift maneja transacciones para asegurar que ambas operaciones (o ninguna) se completen.
      await ticketDao.db.transaction(() async {
        // 1. Creamos el Companion para el Boleto
        final ticketCompanion = TicketsCompanion(
          clientId: Value(ticket.clientId),
          pnr: Value(ticket.pnr),
          emissionDate: Value(ticket.emissionDate),
          transportType: Value(ticket.transportType.name),
          ticketNumber: Value(ticket.ticketNumber),
          // ... (todos los demás campos del ticket)
          totalPrice: Value(ticket.totalPrice),
          commission: Value(ticket.commission),
        );

        // 2. Insertamos el boleto y obtenemos el ID recién creado
        final newTicketId = await ticketDao.insertTicket(ticketCompanion);

        // 3. Para cada segmento en la entidad, lo insertamos asociándolo al nuevo ID
        for (final segment in ticket.segments) {
          final segmentCompanion = FlightSegmentsCompanion(
            ticketId: Value(newTicketId),
            airlineCode: Value(segment.airlineCode),
            flightNumber: Value(segment.flightNumber),
            origin: Value(segment.origin),
            destination: Value(segment.destination),
            departureDate: Value(segment.departureDate),
            arrivalDate: Value(segment.arrivalDate),
          );
          await ticketDao.insertFlightSegment(segmentCompanion);
        }
      });
    } catch (e) {
      throw CacheException('Error al guardar el boleto: ${e.toString()}');
    }
  }

  @override
  Future<void> updateTicket(TicketModel ticket) async {
    try {
      await ticketDao.db.transaction(() async {
        // 1. Actualiza el registro principal del boleto.
        await ticketDao.updateTicket(ticket.toCompanion(false)); // Usamos un helper que crearemos

        // 2. Elimina todos los segmentos de vuelo antiguos asociados con este boleto.
        await ticketDao.deleteFlightSegmentsForTicket(ticket.id);

        // 3. Inserta los nuevos segmentos de vuelo de la entidad actualizada.
        for (final segment in ticket.segments) {
          final segmentCompanion = FlightSegmentsCompanion(
            ticketId: Value(ticket.id),
            // ... (todos los campos del segmento)
          );
          await ticketDao.insertFlightSegment(segmentCompanion);
        }
      });
    } catch (e) {
      throw CacheException('Error al actualizar el boleto: ${e.toString()}');
    }
  }
}