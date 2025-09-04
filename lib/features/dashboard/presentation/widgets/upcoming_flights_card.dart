import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/presentation/bloc/dashboard_bloc.dart';
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
              ...tickets.map((ticket) =>
                _buildFlightRow(context, ticket)
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightRow(BuildContext context, TicketEntity ticket) {
    // Tomamos el primer segmento para mostrar la información principal
    final segment = ticket.segments.first;
    final formattedDate = DateFormat('dd MMM, HH:mm').format(segment.departureDate);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text('${segment.origin} → ${segment.destination}', style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(formattedDate, style: const TextStyle(color: AppColors.fontSubtitleLight)),
          if (ticket.client?.phone != null && ticket.client!.phone!.isNotEmpty)
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
              onPressed: () {
                context.read<DashboardBloc>().add(SendFlightReminder(ticket));
              },
              tooltip: 'Enviar recordatorio de vuelo',
            ),
        ],
      ),
    );
  }
}