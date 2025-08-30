import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/client_entity.dart';
import '../repositories/i_client_repository.dart';

/// ---
/// [GetAllClientsUseCase] es el caso de uso específico para obtener la lista de clientes.
///
/// Implementa la clase base [UseCase] y orquesta la llamada al repositorio
/// para cumplir con una única responsabilidad de negocio.
///
/// No toma parámetros, por lo que se usa `void` en la definición del [UseCase].
/// ---
class GetAllClientsUseCase implements UseCase<List<ClientEntity>, void> {
  final IClientRepository repository;

  /// El constructor requiere una implementación de [IClientRepository].
  /// Esta dependencia será inyectada usando `get_it`.
  GetAllClientsUseCase(this.repository);

  /// ---
  /// Ejecuta el caso de uso.
  ///
  /// Llama al método [getAllClients] del repositorio y devuelve el resultado.
  /// La lógica aquí es simple, pero en casos de uso más complejos, aquí es
  /// donde se realizarían validaciones o combinaciones de datos.
  /// ---
  @override
  Future<Either<Failure, List<ClientEntity>>> call(void params) async {
    return await repository.getAllClients();
  }
}