import 'package:wonder_trip_travel_crm/core/db/database.dart';

/// ---
/// /// [UpcomingFlight] es una clase de datos simple para contener el resultado
/// /// de la consulta JOIN que busca los próximos vuelos.
/// ///
/// /// Agrupa un segmento de vuelo, su boleto padre y el cliente asociado.
/// ---
class UpcomingFlight {
  final FlightSegment segment;
  final Ticket ticket;
  final Client client;

  UpcomingFlight({
    required this.segment,
    required this.ticket,
    required this.client,
  });
}