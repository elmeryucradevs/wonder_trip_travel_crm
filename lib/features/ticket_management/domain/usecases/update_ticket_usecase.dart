import 'package:dartz/dartz.dart';
import 'package:wonder_trip_travel_crm/core/error/failures.dart';
import 'package:wonder_trip_travel_crm/core/usecases/usecase.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/ticket_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/repositories/i_ticket_repository.dart';

/// ---
/// [UpdateTicketUseCase] define el caso de uso para actualizar un boleto existente.
/// ---
class UpdateTicketUseCase implements UseCase<void, TicketEntity> {
  final ITicketRepository repository;

  UpdateTicketUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(TicketEntity params) async {
    return await repository.updateTicket(params);
  }
}