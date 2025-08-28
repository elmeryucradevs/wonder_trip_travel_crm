import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/ticket_entity.dart';
import 'package:intl/intl.dart';

class TicketListItem extends StatelessWidget {
  final TicketEntity ticket;
  const TicketListItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedDate = DateFormat('dd MMM yyyy').format(ticket.emissionDate);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.accentLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.airplane_ticket_outlined, color: AppColors.accentLight),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PNR: ${ticket.pnr}',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.fontTitleLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Emitido: $formattedDate',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.fontSubtitleLight,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Comisión: + \$${(ticket.commission ?? 0.0).toStringAsFixed(2)}',
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.primaryLight,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}