import 'package:dartz/dartz.dart';
import 'package:wonder_trip_travel_crm/core/error/failures.dart';
import 'package:wonder_trip_travel_crm/core/usecases/usecase.dart';
import 'package:wonder_trip_travel_crm/features/ticket_import/domain/entities/parsed_ticket_data.dart';
import 'package:wonder_trip_travel_crm/features/ticket_import/domain/services/ticket_parser_service.dart';

class ParseTicketFromTextUseCase implements UseCase<ParsedTicketData, String> {
  final TicketParserService parserService;

  ParseTicketFromTextUseCase(this.parserService);

  @override
  Future<Either<Failure, ParsedTicketData>> call(String params) async {
    try {
      final parsedData = parserService.parse(params);
      return Right(parsedData);
    } catch (e) {
      return const Left(ParsingFailure('No se pudo analizar el texto del boleto.'));
    }
  }
}