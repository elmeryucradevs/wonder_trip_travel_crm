import 'dart:typed_data'; // Usaremos esto en lugar de dart:io
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wonder_trip_travel_crm/core/error/failures.dart';
import 'package:wonder_trip_travel_crm/features/ticket_import/domain/repositories/i_pdf_repository.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfRepositoryImpl implements IPdfRepository {
  @override
  Future<Either<Failure, String>> pickAndExtractTextFromPdf() async {
    try {
      // 1. Usamos file_picker para seleccionar un solo PDF.
      //    En la web, pedimos que nos entregue los bytes del fichero.
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true, // ¡Importante! Esto nos da acceso a los bytes.
      );

      // 2. Verificamos que el usuario seleccionó un fichero y que tenemos los bytes.
      if (result != null && result.files.single.bytes != null) {
        final Uint8List fileBytes = result.files.single.bytes!;

        // 3. Usamos Syncfusion directamente con los bytes del PDF.
        final PdfDocument document = PdfDocument(inputBytes: fileBytes);
        String extractedText = PdfTextExtractor(document).extractText();
        document.dispose();

        if (extractedText.isEmpty) {
          return Left(CacheFailure('No se pudo extraer texto del PDF. El fichero podría estar vacío o ser una imagen.'));
        }

        return Right(extractedText);
      } else {
        // El usuario canceló la selección de fichero
        return Left(CacheFailure('No se seleccionó ningún fichero.'));
      }
    } catch (e) {
      return Left(CacheFailure('Error al procesar el PDF: ${e.toString()}'));
    }
  }
}