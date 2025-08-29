// lib/features/ticket_management/presentation/bloc/ticket_form_event.dart

part of 'ticket_form_bloc.dart';

abstract class TicketCreationEvent extends Equatable {
  const TicketCreationEvent();
  @override
  List<Object?> get props => [];
}

class UpdateTicketSubmitted extends TicketCreationEvent {
  final TicketEntity updatedTicket;
  const UpdateTicketSubmitted(this.updatedTicket);

  @override
  List<Object?> get props => [updatedTicket];
}

class CreateTicketSubmitted extends TicketCreationEvent {
  final int clientId;
  // Datos del Boleto
  final String pnr;
  final String? ticketNumber;
  final String issuingAgent;
  final DateTime emissionDate;
  final String status;
  final String currency;
  final String flightType;
  final double totalPrice;
  final double? commission;
  final String? passengerCategory; // NUEVO: Categoría del pasajero
  final bool? unaccompaniedMinor; // NUEVO: Indica si un menor viaja solo

  final TransportType transportType;
  final String? stopovers;

  // Datos del Segmento de Ida
  final String segmentAirline;
  final String segmentFlightNumber;
  final String segmentOrigin;
  final String segmentDestination;
  final DateTime segmentDepartureTime;
  final DateTime segmentArrivalTime;

  // --- NUEVO CAMPO OPCIONAL PARA EL SEGMENTO DE VUELTA ---
  final FlightSegmentEntity? returnSegment;

  final String? originalTicketNumber;

  const CreateTicketSubmitted({
    required this.clientId,
    required this.pnr,
    this.ticketNumber,
    required this.issuingAgent,
    required this.emissionDate,
    required this.status,
    required this.currency,
    required this.flightType,
    required this.totalPrice,
    this.commission,
    required this.transportType,
    this.stopovers,
    required this.segmentAirline,
    required this.segmentFlightNumber,
    required this.segmentOrigin,
    required this.segmentDestination,
    required this.segmentDepartureTime,
    required this.segmentArrivalTime,
    this.returnSegment,
    this.passengerCategory,
    this.unaccompaniedMinor,
    this.originalTicketNumber,
  });

  @override
  List<Object?> get props => [
    clientId, pnr, totalPrice, emissionDate, status, 
    currency, flightType,  commission, transportType, 
    stopovers, segmentAirline, segmentFlightNumber, segmentOrigin, 
    segmentDestination, segmentDepartureTime, segmentArrivalTime, returnSegment,
    ticketNumber, issuingAgent, passengerCategory, unaccompaniedMinor, originalTicketNumber,

  ];
}