import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/i_ticket_repository.dart';

class GetTotalTicketsUseCase implements UseCase<int, void> {
  final ITicketRepository repository;

  GetTotalTicketsUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(void params) async {
    return await repository.getTotalTickets();
  }
}