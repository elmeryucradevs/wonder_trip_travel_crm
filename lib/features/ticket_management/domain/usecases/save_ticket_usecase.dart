import 'package:dartz/dartz.dart';
import 'package:wonder_trip_travel_crm/core/error/failures.dart';
import 'package:wonder_trip_travel_crm/core/usecases/usecase.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/ticket_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/repositories/i_ticket_repository.dart';

/// ---
/// /// [SaveTicketUseCase] define el caso de uso para guardar un nuevo boleto.
/// ///
/// /// Recibe una [TicketEntity] que ya contiene sus segmentos de vuelo y la pasa
/// /// al repositorio para ser persistida.
/// ---
class SaveTicketUseCase implements UseCase<void, TicketEntity> {
  final ITicketRepository repository;

  SaveTicketUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(TicketEntity params) async {
    return await repository.saveTicket(params);
  }
}