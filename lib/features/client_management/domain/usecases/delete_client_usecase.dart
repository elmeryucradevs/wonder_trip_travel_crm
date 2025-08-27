import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/i_client_repository.dart';

class DeleteClientUseCase implements UseCase<void, int> {
  final IClientRepository repository;
  DeleteClientUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await repository.deleteClient(params);
  }
}