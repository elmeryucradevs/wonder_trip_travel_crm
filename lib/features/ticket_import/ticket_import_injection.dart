import 'package:get_it/get_it.dart';
import 'data/repositories/pdf_repository_impl.dart';
import 'domain/repositories/i_pdf_repository.dart';
import 'domain/services/ticket_parser_service.dart';
import 'domain/usecases/extract_text_from_pdf_usecase.dart';
import 'domain/usecases/parse_ticket_from_text_usecase.dart';
import 'presentation/bloc/ticket_import_bloc.dart';

final sl = GetIt.instance;

Future<void> initTicketImportFeature() async {
  // BLoC
  sl.registerFactory(() => TicketImportBloc(
        extractTextFromPdfUseCase: sl(),
        parseTicketFromTextUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => ExtractTextFromPdfUseCase(sl()));
  sl.registerLazySingleton(() => ParseTicketFromTextUseCase(sl()));

  // Services
  sl.registerLazySingleton(() => TicketParserService());

  // Repository
  sl.registerLazySingleton<IPdfRepository>(() => PdfRepositoryImpl());
}