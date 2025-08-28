import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ticket_entity.dart';
import '../repositories/i_ticket_repository.dart';

class GetTicketsForClientUseCase implements UseCase<List<TicketEntity>, int> {
  final ITicketRepository repository;

  GetTicketsForClientUseCase(this.repository);

  @override
  Future<Either<Failure, List<TicketEntity>>> call(int params) async {
    return await repository.getTicketsForClient(params);
  }
}