import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/ticket_entity.dart';

class UpcomingFlightsCard extends StatelessWidget {
  final List<TicketEntity> tickets;
  const UpcomingFlightsCard({super.key, required this.tickets});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flight_takeoff, color: AppColors.accentLight),
                const SizedBox(width: 8),
                Text(
                  'Próximos Vuelos',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.fontTitleLight,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            if (tickets.isEmpty)
              const Text('No hay vuelos programados próximamente.')
            else
              ...tickets.expand((ticket) => ticket.segments.map((segment) =>
                _buildFlightRow(ticket, segment)
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightRow(TicketEntity ticket, dynamic segment) {
    final formattedDate = DateFormat('dd MMM, HH:mm').format(segment.departureDate);
    // TODO: Necesitamos el nombre del cliente aquí. Esto requerirá un refactor del modelo.
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text('${segment.origin} → ${segment.destination}', style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(formattedDate, style: const TextStyle(color: AppColors.fontSubtitleLight)),
        ],
      ),
    );
  }
}