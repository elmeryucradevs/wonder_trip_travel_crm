import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/i_client_repository.dart';

class GetTotalClientsUseCase implements UseCase<int, void> {
  final IClientRepository repository;

  GetTotalClientsUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(void params) async {
    return await repository.getTotalClients();
  }
}