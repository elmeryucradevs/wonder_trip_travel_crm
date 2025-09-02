import 'package:dartz/dartz.dart';
import 'package:wonder_trip_travel_crm/core/error/failures.dart';
import 'package:wonder_trip_travel_crm/core/usecases/usecase.dart';
import 'package:wonder_trip_travel_crm/features/ticket_import/domain/repositories/i_pdf_repository.dart';

class ExtractTextFromPdfUseCase implements UseCase<String, void> {
  final IPdfRepository repository;

  ExtractTextFromPdfUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(void params) async {
    return await repository.pickAndExtractTextFromPdf();
  }
}