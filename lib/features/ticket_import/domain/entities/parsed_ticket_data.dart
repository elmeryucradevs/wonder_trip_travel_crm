// lib/features/ticket_import/domain/entities/parsed_ticket_data.dart
import 'package:equatable/equatable.dart';

/// ---
/// [ParsedTicketData] es una clase simple para contener los datos extraídos
/// del texto de un PDF antes de convertirlos en una TicketEntity completa.
///
/// Todos los campos son opcionales (`String?`) porque el parseo puede fallar
/// para algunos campos dependiendo del formato del PDF.
/// ---
class ParsedTicketData extends Equatable {
  final String? pnr;
  final String? passengerName;
  final String? ticketNumber;
  final String? totalPrice;
  final String? currency;
  final String? origin;
  final String? destination;
  final String? flightNumber;
  final String? airline;
  final String? departureDate;
  final String? departureTime;
  final String? arrivalDate;
  final String? arrivalTime;
  final String? provider;
  final String? emissionDate;


  const ParsedTicketData({
    this.pnr,
    this.passengerName,
    this.ticketNumber,
    this.totalPrice,
    this.currency,
    this.origin,
    this.destination,
    this.flightNumber,
    this.airline,
    this.departureDate,
    this.departureTime,
    this.arrivalDate,
    this.arrivalTime,
    this.provider,
    this.emissionDate,
  });

  @override
  List<Object?> get props => [
        pnr,
        passengerName,
        ticketNumber,
        totalPrice,
        currency,
        origin,
        destination,
        flightNumber,
        airline,
        departureDate,
        departureTime,
        arrivalDate,
        arrivalTime,
        provider,
        emissionDate,
      ];
}