import 'package:dartz/dartz.dart';
import 'package:wonder_trip_travel_crm/core/error/failures.dart';

abstract class IPdfRepository {
  /// Selecciona un fichero PDF del dispositivo y extrae su contenido de texto.
  /// Devuelve el texto extraído en caso de éxito.
  Future<Either<Failure, String>> pickAndExtractTextFromPdf();
}