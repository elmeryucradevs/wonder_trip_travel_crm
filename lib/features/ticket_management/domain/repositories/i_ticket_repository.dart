import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ticket_entity.dart';

abstract class ITicketRepository {
  /// Obtiene una lista de boletos para un ID de cliente específico.
  Future<Either<Failure, List<TicketEntity>>> getTicketsForClient(int clientId);
  Future<Either<Failure, void>> saveTicket(TicketEntity ticket);
  Future<Either<Failure, void>> updateTicket(TicketEntity ticket);
  Future<Either<Failure, void>> deleteTicket(int ticketId);
}