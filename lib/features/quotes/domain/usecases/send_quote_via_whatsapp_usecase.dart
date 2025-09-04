import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/core/error/failures.dart';
import 'package:wonder_trip_travel_crm/core/usecases/usecase.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/usecases/open_whatsapp_chat_usecase.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/flight_segment_entity.dart';


/// Caso de uso para formatear y enviar una cotización de vuelo por WhatsApp.
class SendQuoteViaWhatsAppUseCase implements UseCase<void, SendQuoteParams> {
  final OpenWhatsAppChatUseCase _openWhatsAppChatUseCase;

  SendQuoteViaWhatsAppUseCase(this._openWhatsAppChatUseCase);

  @override
  Future<Either<Failure, void>> call(SendQuoteParams params) async {
    final message = _formatQuote(params);
    return await _openWhatsAppChatUseCase(
      OpenWhatsAppChatParams(
        phoneNumber: params.clientPhone,
        message: message,
      ),
    );
  }

  /// Formatea los datos de la cotización en un mensaje de texto atractivo.
  String _formatQuote(SendQuoteParams params) {
    final buffer = StringBuffer();
    buffer.writeln('✈️ *Cotización de Vuelo - Wonder Trip Travel* ✈️');
    buffer.writeln();
    buffer.writeln('¡Hola! Aquí tienes la cotización que solicitaste:');
    buffer.writeln();
    
    for (int i = 0; i < params.segments.length; i++) {
      final segment = params.segments[i];
      buffer.writeln('*Trayecto ${i + 1}: ${segment.origin} ➡️ ${segment.destination}*');
      buffer.writeln(' - *Aerolínea:* ${segment.airlineCode}'); // Corrected
      buffer.writeln(' - *Vuelo:* ${segment.flightNumber}');
      buffer.writeln(' - *Salida:* ${DateFormat.yMMMMd('es').add_Hm().format(segment.departureDate)}'); // Corrected
      buffer.writeln(' - *Llegada:* ${DateFormat.yMMMMd('es').add_Hm().format(segment.arrivalDate)}'); // Corrected
      buffer.writeln();
    }
    
    buffer.writeln('*Detalles de la Tarifa:*');
    buffer.writeln(' - *Precio por pasajero:* \$${params.price.toStringAsFixed(2)} USD');
    buffer.writeln(' - *Incluye:* ${params.includes}');
    buffer.writeln();

    if (params.notes.isNotEmpty) {
      buffer.writeln('*Notas Importantes:*');
      buffer.writeln(params.notes);
      buffer.writeln();
    }
    
    buffer.writeln('Esta cotización es válida por 24 horas. ¡Estamos a tu disposición para confirmar la reserva!');
    
    return buffer.toString();
  }
}

/// Parámetros para [SendQuoteViaWhatsAppUseCase].
class SendQuoteParams {
  final String clientPhone;
  final List<FlightSegmentEntity> segments;
  final double price;
  final String includes;
  final String notes;

  SendQuoteParams({
    required this.clientPhone,
    required this.segments,
    required this.price,
    required this.includes,
    required this.notes,
  });
}