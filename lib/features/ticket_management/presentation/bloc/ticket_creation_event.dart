part of 'ticket_creation_bloc.dart';

abstract class TicketCreationEvent extends Equatable {
  const TicketCreationEvent();
  @override
  List<Object?> get props => [];
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
  final double baseFare;
  final double totalPrice;
  final double? commission;

  // Datos del Primer Segmento
  final String segmentAirline;
  final String segmentFlightNumber;
  final String segmentOrigin;
  final String segmentDestination;
  final DateTime segmentDepartureTime;
  final DateTime segmentArrivalTime;

  const CreateTicketSubmitted({
    required this.clientId,
    required this.pnr,
    this.ticketNumber,
    required this.issuingAgent,
    required this.emissionDate,
    required this.status,
    required this.currency,
    required this.baseFare,
    required this.totalPrice,
    this.commission,
    required this.segmentAirline,
    required this.segmentFlightNumber,
    required this.segmentOrigin,
    required this.segmentDestination,
    required this.segmentDepartureTime,
    required this.segmentArrivalTime,
  });

  @override
  List<Object?> get props => [clientId, pnr, totalPrice];
}