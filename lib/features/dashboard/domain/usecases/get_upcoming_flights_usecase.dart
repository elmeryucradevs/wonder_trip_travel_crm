import 'package:dartz/dartz.dart';
import 'package:wonder_trip_travel_crm/core/error/failures.dart';
import 'package:wonder_trip_travel_crm/core/usecases/usecase.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/ticket_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/repositories/i_ticket_repository.dart';

class GetUpcomingFlightsUseCase implements UseCase<List<TicketEntity>, void> {
  final ITicketRepository repository;

  GetUpcomingFlightsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TicketEntity>>> call(void params) async {
    return await repository.getUpcomingFlights();
  }
}