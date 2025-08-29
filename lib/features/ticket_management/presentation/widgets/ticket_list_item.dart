// lib/features/ticket_management/presentation/widgets/ticket_list_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../client_management/domain/entities/client_entity.dart';
import '../../domain/entities/ticket_entity.dart';
import 'package:intl/intl.dart';

import '../bloc/ticket_list_bloc.dart';
import '../pages/ticket_detail_page.dart';

class TicketListItem extends StatelessWidget {
  final TicketEntity ticket;
  final ClientEntity client;
  const TicketListItem({super.key, required this.ticket, required this.client});

  // --- WIDGET AUXILIAR PARA LAS LEYENDAS ---
  Widget _buildLegend(BuildContext context, IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedDate = DateFormat('dd MMM yyyy').format(ticket.emissionDate);
    final isExchange = ticket.originalTicketNumber != null && ticket.originalTicketNumber!.isNotEmpty;
    final commission = ticket.commission ?? 0.0;
    final commissionColor = commission > 0 ? Colors.green.shade700 : Colors.red.shade700;

    // --- LÓGICA PARA EL ESTADO ---
    final statusText = ticket.status?.toUpperCase() ?? 'N/A';
    Color statusColor;
    IconData statusIcon;

    switch (statusText) {
      case 'CONFIRMADO':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle_outline;
        break;
      case 'CANCELADO':
        statusColor = Colors.red;
        statusIcon = Icons.cancel_outlined;
        break;
      case 'REEMBOLSADO':
        statusColor = Colors.orange;
        statusIcon = Icons.history_outlined;
        break;
      default:
        statusColor = AppColors.fontSubtitleLight;
        statusIcon = Icons.help_outline;
    }


    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<TicketListBloc>(),
                child: TicketDetailPage(ticket: ticket, client: client),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (ticket.transportType == TransportType.aereo ? AppColors.accentLight : Colors.orange).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  ticket.transportType == TransportType.aereo ? Icons.flight_takeoff : Icons.directions_bus,
                  color: ticket.transportType == TransportType.aereo ? AppColors.accentLight : Colors.orange
                ),
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
                      'Boleto: ${ticket.ticketNumber?.isNotEmpty == true ? ticket.ticketNumber : "Sin número"}',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.fontSubtitleLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Emitido: $formattedDate',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.fontSubtitleLight,
                      ),
                    ),
                     const SizedBox(height: 8),
                    // --- LEYENDAS MEJORADAS ---
                    Row(
                      children: [
                        _buildLegend(
                          context,
                          isExchange ? Icons.sync_alt : Icons.star_border,
                          isExchange ? 'CANJE' : 'ORIGINAL',
                          isExchange ? Colors.blueAccent : Colors.amber.shade700,
                        ),
                        const SizedBox(width: 12),
                        // --- NUEVA LEYENDA DE ESTADO ---
                        _buildLegend(context, statusIcon, statusText, statusColor),
                      ],
                    ),
                  ],
                ),
              ),
              // --- COLOR CONDICIONAL PARA LA COMISIÓN ---
              Column(
                children: [
                  Text(
                    'Comisión:',
                    style: textTheme.titleMedium?.copyWith(
                      color: commissionColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' ${ticket.currency} ${commission.toStringAsFixed(2)} ',
                    style: textTheme.titleMedium?.copyWith(
                      color: commissionColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}