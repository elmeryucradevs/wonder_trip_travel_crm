import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wonder_trip_travel_crm/features/ticket_import/domain/entities/parsed_ticket_data.dart';
import 'package:wonder_trip_travel_crm/features/ticket_import/domain/usecases/extract_text_from_pdf_usecase.dart';

import '../../domain/usecases/parse_ticket_from_text_usecase.dart';

part 'ticket_import_event.dart';
part 'ticket_import_state.dart';

class TicketImportBloc extends Bloc<TicketImportEvent, TicketImportState> {
  final ExtractTextFromPdfUseCase extractTextFromPdfUseCase;
  final ParseTicketFromTextUseCase parseTicketFromTextUseCase;

  TicketImportBloc({
    required this.extractTextFromPdfUseCase,
    required this.parseTicketFromTextUseCase,
  }) : super(TicketImportInitial()) {
    on<PdfImportButtonPressed>(_onImportPressed);
  }

  Future<void> _onImportPressed(
      PdfImportButtonPressed event, Emitter<TicketImportState> emit) async {
    emit(TicketImportLoading());

    final textResult = await extractTextFromPdfUseCase(null);

    await textResult.fold(
      (failure) async => emit(TicketImportFailure(failure.message)),
      (text) async {
        // Si la extracción de texto fue exitosa, ahora lo parseamos
        final parsedResult = await parseTicketFromTextUseCase(text);
        parsedResult.fold(
          (failure) => emit(TicketImportFailure(failure.message)),
          (parsedData) => emit(TicketImportSuccess(parsedData)),
        );
      },
    );
  }
}