import 'package:equatable/equatable.dart';
import 'flight_segment_entity.dart'; 

enum TransportType { aereo, terrestre }

class TicketEntity extends Equatable {
  final int id;
  final int clientId;
  final String pnr;
  final DateTime emissionDate;

  final double? commission;
  final int? originalTicketId;

  final TransportType transportType;
  final String? ticketNumber;
  final String? flightType;
  final String? passengerCategory;
  final String? issuingAgent;
  final String? status;
  final double baseFare;
  final String currency;
  final double? taxBO;
  final double? taxA7;
  final double? taxQM;
  final double? taxOM;
  final double? otherTaxes;
  final double totalPrice;

  final DateTime createdAt;
  final DateTime updatedAt;

  final List<FlightSegmentEntity> segments;

  const TicketEntity({
    required this.id,
    required this.clientId,
    required this.pnr,
    required this.emissionDate,
    required this.transportType,
    this.ticketNumber,
    this.flightType,
    this.passengerCategory,
    this.issuingAgent,
    this.status,
    required this.baseFare,
    required this.currency,
    this.taxBO,
    this.taxA7,
    this.taxQM,
    this.taxOM,
    this.otherTaxes,
    required this.totalPrice,

    this.commission,
    this.originalTicketId,

    required this.createdAt,
    required this.updatedAt,

    this.segments = const [], 
  });

  @override
  List<Object?> get props => [
        id, clientId, pnr, emissionDate, transportType, ticketNumber,
        flightType, passengerCategory, issuingAgent, status, baseFare,
        currency, taxBO, taxA7, taxQM, taxOM, otherTaxes, totalPrice,
        commission, originalTicketId, createdAt, updatedAt, segments 
      ];
}