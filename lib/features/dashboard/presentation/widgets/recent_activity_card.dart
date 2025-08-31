import 'package:flutter/material.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';

class RecentActivityCard extends StatelessWidget {
  final List<ClientEntity> clients;
  const RecentActivityCard({super.key, required this.clients});

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
                const Icon(Icons.history, color: AppColors.primaryLight),
                const SizedBox(width: 8),
                Text(
                  'Clientes Recientes',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.fontTitleLight,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            if (clients.isEmpty)
              const Text('No hay clientes registrados recientemente.')
            else
              ...clients.map((client) => _buildActivityRow(client, context)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityRow(ClientEntity client, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.person_add_alt_1_outlined, size: 20, color: AppColors.fontSubtitleLight),
          const SizedBox(width: 12),
          Expanded(child: Text(client.fullName, overflow: TextOverflow.ellipsis)),
          Text('Añadido', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.fontSubtitleLight)),
        ],
      ),
    );
  }
}