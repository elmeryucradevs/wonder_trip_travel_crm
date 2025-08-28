import 'package:equatable/equatable.dart';

class FlightSegmentEntity extends Equatable {
  final int id;
  final int ticketId;
  final String? airlineCode;
  final String? flightNumber;
  final String origin;
  final String destination;
  final DateTime departureDate;
  final DateTime arrivalDate;

  const FlightSegmentEntity({
    required this.id,
    required this.ticketId,
    this.airlineCode,
    this.flightNumber,
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.arrivalDate,
  });

  @override
  List<Object?> get props => [id, ticketId, origin, destination];
}