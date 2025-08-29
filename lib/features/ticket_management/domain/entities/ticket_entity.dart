// lib/features/ticket_management/domain/entities/ticket_entity.dart

import 'package:equatable/equatable.dart';
import 'flight_segment_entity.dart'; 

enum TransportType { aereo, terrestre }

class TicketEntity extends Equatable {
  final int id;
  final int clientId;
  final String pnr;
  final DateTime emissionDate;

  final double? commission;
  final String? originalTicketNumber;

  final TransportType transportType;
  final String? ticketNumber;
  final String? flightType;
  final String? passengerCategory; 
  final bool? unaccompaniedMinor; 
  final String? issuingAgent;
  final String? status;
  final String currency;
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
    this.unaccompaniedMinor,
    this.issuingAgent,
    this.status,
    required this.currency,
    required this.totalPrice,

    this.commission,
    this.originalTicketNumber,

    required this.createdAt,
    required this.updatedAt,

    this.segments = const [], 
  });

  TicketEntity copyWith({
    String? pnr,
    DateTime? emissionDate,
    String? ticketNumber,
    String? flightType,
    String? passengerCategory,
    bool? unaccompaniedMinor,
    String? issuingAgent,
    String? status,
    String? currency,
    double? totalPrice,
    double? commission,
    List<FlightSegmentEntity>? segments,
  }) {
    return TicketEntity(
      id: id,
      clientId: clientId,
      pnr: pnr ?? this.pnr,
      emissionDate: emissionDate ?? this.emissionDate,
      transportType: transportType, // No se puede cambiar
      ticketNumber: ticketNumber ?? this.ticketNumber,
      flightType: flightType ?? this.flightType,
      passengerCategory: passengerCategory ?? this.passengerCategory,
      unaccompaniedMinor: unaccompaniedMinor ?? this.unaccompaniedMinor,
      issuingAgent: issuingAgent ?? this.issuingAgent,
      status: status ?? this.status,
      currency: currency ?? this.currency,
      totalPrice: totalPrice ?? this.totalPrice,
      commission: commission ?? this.commission,
      originalTicketNumber: originalTicketNumber ?? originalTicketNumber,  // No se puede cambiar
      createdAt: createdAt, // No se puede cambiar
      updatedAt: DateTime.now(), // Se actualiza la fecha
      segments: segments ?? this.segments,
    );
  }

  @override
  List<Object?> get props => [
        id, clientId, pnr, emissionDate, transportType, ticketNumber,
        flightType, passengerCategory, unaccompaniedMinor, issuingAgent, status, 
        currency, totalPrice, commission, originalTicketNumber, createdAt, updatedAt, segments 
      ];
}