import 'package:flutter/material.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';

class StatsCard extends StatelessWidget {
  final int clientCount;
  final int ticketCount;

  const StatsCard({super.key, required this.clientCount, required this.ticketCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(context, 'Clientes Totales', clientCount.toString(), Icons.people, AppColors.primaryLight),
            _buildStatItem(context, 'Boletos Emitidos', ticketCount.toString(), Icons.airplane_ticket, AppColors.accentLight),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 32, color: color),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors.fontTitleLight),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.fontSubtitleLight)),
      ],
    );
  }
}