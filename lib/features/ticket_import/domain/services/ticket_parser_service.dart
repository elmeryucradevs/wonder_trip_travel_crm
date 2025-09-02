// lib/features/ticket_import/domain/services/ticket_parser_service.dart
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/features/ticket_import/domain/entities/parsed_ticket_data.dart';

/// ---
/// [TicketParserService] se encarga de analizar un texto crudo extraído de un PDF
/// y encontrar datos clave utilizando expresiones regulares (RegEx).
///
/// Esta clase es el núcleo de la inteligencia de importación de PDFs.
/// ---
class TicketParserService {
  ParsedTicketData parse(String text) {
    return ParsedTicketData(
      pnr: _findPnr(text),
      passengerName: _findPassengerName(text),
      ticketNumber: _findTicketNumber(text),
      totalPrice: _findTotalPrice(text),
      currency: _findCurrency(text),
      origin: _findOrigin(text),
      destination: _findDestination(text),
      flightNumber: _findFlightNumber(text),
      airline: _findAirline(text),
      departureDate: _findDepartureDate(text),
      departureTime: _findDepartureTime(text),
      arrivalDate: _findArrivalDate(text),
      arrivalTime: _findArrivalTime(text),
      provider: _findProvider(text),
      emissionDate: _findEmissionDate(text),
    );
  }

  String? _findPnr(String text) {
    final patterns = [
      RegExp(r'LOCALIZADOR/RECORD LOCATOR\s*([A-Z0-9]{6})', caseSensitive: false),
      RegExp(r'Código de Reserva:([A-Z0-9]{6})', caseSensitive: false),
      RegExp(r'BOOKING REF\./CODIGO DE RESERVA:\s*[A-Z0-9/]+\s*([A-Z0-9]{6})', caseSensitive: false),
      RegExp(r'Booking ref:\s*([A-Z0-9]{6})', caseSensitive: false),
      RegExp(r'E-TICKET:\s*(\d+)', caseSensitive: false),
    ];
    return _tryPatterns(text, patterns);
  }

  String? _findPassengerName(String text) {
    final patterns = [
      RegExp(r'NOMBRE/NAME\s*([A-Z/,\s]+)', caseSensitive: false),
      RegExp(r'NOMBRE PASAJERO:\s*([A-Z\s]+)', caseSensitive: false),
      RegExp(r'Pasajero\(s\)\s*([A-Z\s]+)', caseSensitive: false),
      RegExp(r'NAME:\s*([A-Z/]+\s*[A-Z]+)', caseSensitive: false),
      RegExp(r'Traveler\s*([A-Za-z\s]+)', caseSensitive: false),
    ];
    final result = _tryPatterns(text, patterns);
    return result?.replaceAll('/', ' ').trim().split(' ').reversed.join(' ');
  }

  String? _findTicketNumber(String text) {
    final patterns = [
      RegExp(r'NRO\. BILLETE/TICKET NUMBER\s*([0-9-]{13,})', caseSensitive: false),
      RegExp(r'TICKET NUMBER/NRO DE BOLETO\s*:\s*([0-9-]+)', caseSensitive: false),
      RegExp(r'E-ticket\s*[A-Z]{2}\s*([\d-]+)', caseSensitive: false),
    ];
    return _tryPatterns(text, patterns)?.replaceAll('-', '');
  }

  String? _findTotalPrice(String text) {
    final patterns = [
      RegExp(r'TOTAL\s*BOB\s*([\d,]+\.\d{2})', caseSensitive: false),
      RegExp(r'TOTAL A PAGAR BS\s*([\d,]+,\d{2})', caseSensitive: false),
      RegExp(r'TOTAL\s*:\s*BOB\s*([\d,]+\.\d{2})', caseSensitive: false),
       RegExp(r'Tarifa total:\s*BOB\s*(\d+)', caseSensitive: false),
    ];
    return _tryPatterns(text, patterns)?.replaceAll(',', '');
  }

  String? _findCurrency(String text) {
    if (text.contains('BOB')) return 'BOB';
    if (text.contains('USD')) return 'USD';
    return 'BOB';
  }

  String? _findOrigin(String text) {
    final patterns = [
      RegExp(r'Desde / From\s*[A-Z\s]+\(([A-Z]{3})\)', caseSensitive: false),
      RegExp(r'Ruta:\s*([A-Z]{3})\s*-', caseSensitive: false),
       RegExp(r'V\s*([A-Z]{3,})', caseSensitive: false),
    ];
     return _tryPatterns(text, patterns);
  }

  String? _findDestination(String text) {
    final patterns = [
      RegExp(r'A/ To\s*[A-Z\s]+\(([A-Z]{3})\)', caseSensitive: false),
      RegExp(r'Ruta:\s*[A-Z]{3}\s*-\s*([A-Z]{3})', caseSensitive: false),
    ];
    return _tryPatterns(text, patterns);
  }

  String? _findFlightNumber(String text) {
    final patterns = [
      RegExp(r'VUELO\s*FLIGHT\s*([A-Z0-9]+)', caseSensitive: false),
      RegExp(r'Vuelo No:\s*(\d+)', caseSensitive: false),
       RegExp(r'8J\d+', caseSensitive: false),
    ];
     return _tryPatterns(text, patterns);
  }

  String? _findAirline(String text) {
    if (text.contains('Boliviana de Aviación') || text.contains('Boliviana De Aviacion')) return 'OB';
    if (text.contains('TAMep')) return 'Z8';
    if (text.contains('ECOJET')) return '8J';
    return null;
  }

  String? _findDepartureDate(String text) {
    final patterns = [
      RegExp(r'SALIDA\s*DEPARTURE\s*(\d{2}[A-Z]{3}\d{2})', caseSensitive: false),
      RegExp(r'Fecha de vuelo:\s*[a-z]+,\s*(\d{1,2}\s*[a-z]+\s*\d{4})', caseSensitive: false),
      RegExp(r'Fecha:\s*(\d{2}-[a-z]{3}\s*-\s*\d{4})', caseSensitive: false),
    ];
     return _formatDate(_tryPatterns(text, patterns));
  }

    String? _findDepartureTime(String text) {
    final patterns = [
      RegExp(r'SALIDA\s*DEPARTURE\s*\d{2}[A-Z]{3}\d{2}\s*(\d{4})', caseSensitive: false),
      RegExp(r'Salida\s*(\d{2}:\d{2})', caseSensitive: false),
      RegExp(r'Hora:\s*(\d{2}:\d{2})', caseSensitive: false),
    ];
    return _tryPatterns(text, patterns);
  }

  String? _findArrivalDate(String text) {
    final patterns = [
      RegExp(r'LLEGADA\s*ARRIVAL\s*(\d{2}[A-Z]{3}\d{2})', caseSensitive: false),
      RegExp(r'Fecha de vuelo:\s*[a-z]+,\s*(\d{1,2}\s*[a-z]+\s*\d{4})', caseSensitive: false),
    ];
     return _formatDate(_tryPatterns(text, patterns));
  }

  String? _findArrivalTime(String text) {
    final patterns = [
      RegExp(r'LLEGADA\s*ARRIVAL\s*\d{2}[A-Z]{3}\d{2}\s*(\d{4})', caseSensitive: false),
      RegExp(r'Llegada\s*(\d{2}:\d{2})', caseSensitive: false),
    ];
    return _tryPatterns(text, patterns);
  }

  String? _findProvider(String text) {
    final patterns = [
      RegExp(r'EMITIDO POR:\s*(.+)', caseSensitive: false),
      RegExp(r'Agente:\s*(.+)', caseSensitive: false),
    ];
    return _tryPatterns(text, patterns);
  }

    String? _findEmissionDate(String text) {
    final patterns = [
      RegExp(r'EMITIDO/ISSUED\s*(\d{2}\s*[A-Za-z]{3}\s*\d{4})', caseSensitive: false),
      RegExp(r'Fecha de emisión:\s*(\d{1,2}\s*[a-z]+\s*\d{4})', caseSensitive: false),
      RegExp(r'Fecha Emision:\s*(\d{2}/\d{2}/\d{4})', caseSensitive: false),
    ];
    return _formatDate(_tryPatterns(text, patterns));
  }


  String? _tryPatterns(String text, List<RegExp> patterns) {
    for (final pattern in patterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        return match.group(1);
      }
    }
    return null;
  }

  String? _formatDate(String? dateString) {
    if (dateString == null) return null;
    try {
      // Intentar varios formatos de fecha
      final formats = [
        DateFormat('ddMMMyy', 'en_US'),
        DateFormat('d MMMM yyyy', 'es_ES'),
         DateFormat('dd-MMM-yyyy', 'es_ES'),
        DateFormat('dd/MM/yyyy'),
      ];
      for (final format in formats) {
        try {
          final date = format.parse(dateString);
          return DateFormat('dd/MM/yyyy').format(date);
        } catch (_) {}
      }
      return dateString;
    } catch (_) {
      return dateString;
    }
  }
}