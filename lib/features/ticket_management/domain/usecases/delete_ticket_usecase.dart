import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/i_ticket_repository.dart';

class DeleteTicketUseCase implements UseCase<void, int> {
  final ITicketRepository repository;
  DeleteTicketUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await repository.deleteTicket(params);
  }
}