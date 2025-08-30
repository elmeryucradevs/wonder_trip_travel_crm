import 'package:dartz/dartz.dart';
import 'package:wonder_trip_travel_crm/core/error/failures.dart';
import 'package:wonder_trip_travel_crm/core/usecases/usecase.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/repositories/i_client_repository.dart';

class GetClientsWithUpcomingBirthdaysUseCase implements UseCase<List<ClientEntity>, void> {
  final IClientRepository repository;

  GetClientsWithUpcomingBirthdaysUseCase(this.repository);

  @override
  Future<Either<Failure, List<ClientEntity>>> call(void params) async {
    return await repository.getClientsWithUpcomingBirthdays();
  }
}