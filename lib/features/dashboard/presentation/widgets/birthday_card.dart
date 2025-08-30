import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';

class BirthdayCard extends StatelessWidget {
  final List<ClientEntity> clients;
  const BirthdayCard({super.key, required this.clients});

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
                const Icon(Icons.cake_outlined, color: AppColors.primaryLight),
                const SizedBox(width: 8),
                Text(
                  'Próximos Cumpleaños',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.fontTitleLight,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            if (clients.isEmpty)
              const Text('No hay cumpleaños registrados próximamente.')
            else
              ...clients.map((client) => _buildBirthdayRow(client)),
          ],
        ),
      ),
    );
  }

  Widget _buildBirthdayRow(ClientEntity client) {
    final birthday = client.birthDate;
    if (birthday == null) return const SizedBox.shrink();

    final formattedDate = DateFormat('dd \'de\' MMMM').format(birthday);
    final isToday = birthday.day == DateTime.now().day && birthday.month == DateTime.now().month;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(client.fullName, overflow: TextOverflow.ellipsis)),
          Text(formattedDate, style: const TextStyle(color: AppColors.fontSubtitleLight)),
          if (isToday)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Chip(
                label: const Text('HOY'),
                backgroundColor: AppColors.accentLight.withOpacity(0.2),
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
    );
  }
}