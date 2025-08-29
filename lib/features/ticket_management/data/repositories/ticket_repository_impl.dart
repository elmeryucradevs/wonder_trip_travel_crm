import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/repositories/i_ticket_repository.dart';
import '../datasources/ticket_local_data_source.dart';
import '../models/ticket_model.dart';

class TicketRepositoryImpl implements ITicketRepository {
  final ITicketDataSource localDataSource;

  TicketRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<TicketEntity>>> getTicketsForClient(int clientId) async {
    try {
      final localTickets = await localDataSource.getTicketsForClient(clientId);
      return Right(localTickets);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

   @override
  Future<Either<Failure, void>> saveTicket(TicketEntity ticket) async {
    try {
      // La conversión de Entidad a Modelo se hará aquí más adelante si es necesario.
      // Por ahora, asumimos que TicketModel puede ser usado directamente.
      final ticketModel = TicketModel(
        id: ticket.id,
        clientId: ticket.clientId,
        pnr: ticket.pnr,
        emissionDate: ticket.emissionDate,
        transportType: ticket.transportType,
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
        segments: ticket.segments,
      );
      await localDataSource.saveTicket(ticketModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateTicket(TicketEntity ticket) async {
    try {
      // Mapeamos de Entidad a Modelo
      final ticketModel = TicketModel(
        id: ticket.id,
        clientId: ticket.clientId,
        pnr: ticket.pnr,
        emissionDate: ticket.emissionDate,
        transportType: ticket.transportType,
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
        segments: ticket.segments,
      );
      await localDataSource.updateTicket(ticketModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTicket(int ticketId) async {
    try {
      await localDataSource.deleteTicket(ticketId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}