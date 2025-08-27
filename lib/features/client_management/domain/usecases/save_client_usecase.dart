import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/client_entity.dart';
import '../repositories/i_client_repository.dart';

/// ---
/// /// Caso de uso para guardar un cliente (sea nuevo o una actualización).
/// ///
/// /// Extiende nuestra clase base [UseCase] y define la operación de negocio
/// /// para persistir los datos de un cliente.
/// ---
class SaveClientUseCase implements UseCase<void, ClientEntity> {
  final IClientRepository repository;

  SaveClientUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ClientEntity client) async {
    return await repository.saveClient(client);
  }
}