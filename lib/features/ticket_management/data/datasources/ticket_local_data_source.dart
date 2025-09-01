import 'package:drift/drift.dart';

import '../../../../core/db/dao/ticket_dao.dart';
import '../../../../core/db/database.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/flight_segment_entity.dart';
import '../../domain/entities/ticket_entity.dart';
import '../models/ticket_model.dart';

abstract class ITicketDataSource {
  Future<List<TicketModel>> getTicketsForClient(int clientId);
  Future<void> saveTicket(TicketModel ticket);
  Future<void> updateTicket(TicketModel ticket);
  Future<void> deleteTicket(int ticketId);
  Future<List<TicketModel>> getUpcomingFlights();
  Future<int> getTotalTickets();
}

class TicketLocalDataSourceImpl implements ITicketDataSource {
  final TicketDao ticketDao;

  TicketLocalDataSourceImpl({required this.ticketDao});

  @override
  Future<List<TicketModel>> getTicketsForClient(int clientId) async {
    try {
      final ticketsFromDb = await ticketDao.getTicketsForClient(clientId);
      final List<TicketModel> ticketModels = [];
      for (final ticket in ticketsFromDb) {
        final segments = await ticketDao.getFlightSegmentsForTicket(ticket.id);
        
        ticketModels.add(TicketModel(
          id: ticket.id,
          clientId: ticket.clientId,
          pnr: ticket.pnr,
          emissionDate: ticket.emissionDate,
          transportType: ticket.transportType == 'TERRESTRE' ? TransportType.terrestre : TransportType.aereo,
          ticketNumber: ticket.ticketNumber,
          flightType: ticket.flightType,
          passengerCategory: ticket.passengerCategory,
          unaccompaniedMinor: ticket.unaccompaniedMinor,
          issuingAgent: ticket.issuingAgent,
          status: ticket.status,
          currency: ticket.currency,
          totalPrice: ticket.totalPrice,
          commission: ticket.commission,
          originalTicketNumber: ticket.originalTicketNumber,
          createdAt: ticket.createdAt,
          updatedAt: ticket.updatedAt,
          segments: segments.map((s) => FlightSegmentEntity(
              id: s.id,
              ticketId: s.ticketId,
              airlineCode: s.airlineCode,
              flightNumber: s.flightNumber,
              origin: s.origin,
              destination: s.destination,
              departureDate: s.departureDate,
              arrivalDate: s.arrivalDate,
              flightClass: s.flightClass,
              stopover: s.stopover,
          )).toList(),
        ));
      }
      return ticketModels;
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
        final ticketCompanion = ticket.toCompanion(true);

        // 2. Insertamos el boleto y obtenemos el ID recién creado
        final newTicketId = await ticketDao.insertTicket(ticketCompanion);

        // 3. Para cada segmento en la entidad, lo insertamos asociándolo al nuevo ID
        for (final segment in ticket.segments) {
          final segmentCompanion = FlightSegmentsCompanion(
            ticketId: Value(newTicketId),
            airlineCode: Value(segment.airlineCode),
            flightNumber: Value(segment.flightNumber),
            flightClass: Value(segment.flightClass),
            stopover: Value(segment.stopover),
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
            airlineCode: Value(segment.airlineCode),
            flightNumber: Value(segment.flightNumber),
            origin: Value(segment.origin),
            destination: Value(segment.destination),
            departureDate: Value(segment.departureDate),
            arrivalDate: Value(segment.arrivalDate),
            flightClass: Value(segment.flightClass),
            stopover: Value(segment.stopover)
          );
          await ticketDao.insertFlightSegment(segmentCompanion);
        }
      });
    } catch (e) {
      throw CacheException('Error al actualizar el boleto: ${e.toString()}');
    }
  }
  @override
  Future<void> deleteTicket(int ticketId) async {
    try {
      await ticketDao.deleteTicketAndSegments(ticketId);
    } catch (e) {
      throw CacheException('Error al eliminar el boleto: ${e.toString()}');
    }
  }

  @override
  Future<List<TicketModel>> getUpcomingFlights() async {
    try {
      final upcomingFlightsData = await ticketDao.getUpcomingFlightDetails();
      
      // Agrupa segmentos por ID de boleto ya que un boleto puede tener múltiples segmentos próximos
      final Map<int, List<FlightSegment>> segmentsByTicket = {};
      final Map<int, Ticket> uniqueTickets = {};

      for (var flightDetail in upcomingFlightsData) {
        uniqueTickets.putIfAbsent(flightDetail.ticket.id, () => flightDetail.ticket);
        segmentsByTicket.putIfAbsent(flightDetail.ticket.id, () => []).add(flightDetail.segment);
      }

      final List<TicketModel> ticketModels = [];

      for (var ticket in uniqueTickets.values) {
        final segments = segmentsByTicket[ticket.id] ?? [];
        ticketModels.add(
          TicketModel(
            id: ticket.id,
            clientId: ticket.clientId,
            pnr: ticket.pnr,
            emissionDate: ticket.emissionDate,
            transportType: ticket.transportType == 'TERRESTRE' ? TransportType.terrestre : TransportType.aereo,
            ticketNumber: ticket.ticketNumber,
            flightType: ticket.flightType,
            passengerCategory: ticket.passengerCategory,
            unaccompaniedMinor: ticket.unaccompaniedMinor,
            issuingAgent: ticket.issuingAgent,
            status: ticket.status,
            currency: ticket.currency,
            totalPrice: ticket.totalPrice,
            commission: ticket.commission,
            originalTicketNumber: ticket.originalTicketNumber,
            createdAt: ticket.createdAt,
            updatedAt: ticket.updatedAt,
            segments: segments.map((s) => FlightSegmentEntity(
              id: s.id,
              ticketId: s.ticketId,
              airlineCode: s.airlineCode,
              flightNumber: s.flightNumber,
              origin: s.origin,
              destination: s.destination,
              departureDate: s.departureDate,
              arrivalDate: s.arrivalDate,
              flightClass: s.flightClass,
              stopover: s.stopover,
            )).toList(),
          ),
        );
      }

      return ticketModels;
    } catch (e) {
      throw CacheException('Error al obtener próximos vuelos: ${e.toString()}');
    }
  }

  @override
  Future<int> getTotalTickets() async {
    try {
      return await ticketDao.getTotalTickets();
    } catch (e) {
      throw CacheException('Error al obtener el número total de tickets: ${e.toString()}');
    }
  }
}