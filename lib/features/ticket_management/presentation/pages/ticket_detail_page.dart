import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/core/config/injection_container.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/flight_segment_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/ticket_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/presentation/bloc/ticket_list_bloc.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/presentation/pages/ticket_edit_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../client_management/domain/entities/client_entity.dart';
//import '../bloc/ticket_detail_bloc.dart'; // Asumimos que crearemos este BLoC para eliminar

/// ---
/// /// [TicketDetailPage] Muestra una vista completa y detallada de un boleto,
/// /// incluyendo todos sus segmentos y el desglose de tarifas.
/// /// Sirve como un hub central para ver datos y acceder a acciones como editar o eliminar.
/// ---
class TicketDetailPage extends StatelessWidget {
  final TicketEntity ticket;
  final ClientEntity client;

  const TicketDetailPage({super.key, required this.ticket, required this.client});

  @override
  Widget build(BuildContext context) {
    // Usaremos un BlocProvider aquí si añadimos la lógica de eliminación.
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles PNR: ${ticket.pnr}'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.delete_outline),
          //   onPressed: () { /* TODO: Lógica de eliminación */ },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Información General'),
            _buildInfoCard([
              _InfoRow(label: 'Cliente', value: client.fullName),
              _InfoRow(label: 'PNR', value: ticket.pnr),
              _InfoRow(label: 'Nº Boleto', value: ticket.ticketNumber),
              _InfoRow(label: 'Emitido por', value: ticket.issuingAgent),
              _InfoRow(label: 'Fecha Emisión', value: DateFormat('dd MMM yyyy, HH:mm').format(ticket.emissionDate)),
              _InfoRow(label: 'Estado', value: ticket.status?.toUpperCase()),
              _InfoRow(label: 'Tipo de Viaje', value: ticket.flightType),
            ]),
            const SizedBox(height: 24),

            ...ticket.segments.asMap().entries.map((entry) {
              final index = entry.key;
              final segment = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Segmento ${index + 1}: ${segment.origin} → ${segment.destination}'),
                  _buildInfoCard([
                    _InfoRow(label: 'Aerolínea', value: '${segment.airlineCode} ${segment.flightNumber}'),
                    _InfoRow(label: 'Salida', value: DateFormat('dd MMM yyyy, HH:mm').format(segment.departureDate)),
                    _InfoRow(label: 'Llegada', value: DateFormat('dd MMM yyyy, HH:mm').format(segment.arrivalDate)),
                  ]),
                  const SizedBox(height: 24),
                ],
              );
            }),

            _buildSectionTitle(context, 'Desglose de Tarifa'),
            _buildInfoCard([
              _InfoRow(label: 'Tarifa Base', value: '${(ticket.baseFare).toStringAsFixed(2)} ${ticket.currency}'),
              _InfoRow(label: 'Impuesto BO', value: ticket.taxBO?.toStringAsFixed(2)),
              _InfoRow(label: 'Tasa A7 (TUA)', value: ticket.taxA7?.toStringAsFixed(2)),
              _InfoRow(label: 'Cargo QM', value: ticket.taxQM?.toStringAsFixed(2)),
              _InfoRow(label: 'Otros Impuestos', value: ticket.otherTaxes?.toStringAsFixed(2)),
              const Divider(height: 24),
              _InfoRow(label: 'Comisión Agencia', value: '${(ticket.commission ?? 0.0).toStringAsFixed(2)} ${ticket.currency}', isHighlight: true),
              _InfoRow(label: 'Precio Total', value: '${ticket.totalPrice.toStringAsFixed(2)} ${ticket.currency}', isHighlight: true),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<TicketListBloc>(),
                child: TicketEditPage(ticket: ticket, client: client),
              ),
            ),
          );
        },
        child: const Icon(Icons.edit_note),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.fontTitleLight,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final bool isHighlight;

  const _InfoRow({required this.label, this.value, this.isHighlight = false});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final valueColor = isHighlight ? AppColors.primaryLight : AppColors.fontBodyLight;
    final valueWeight = isHighlight ? FontWeight.bold : FontWeight.normal;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140, // Aumentamos el ancho para etiquetas más largas
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.fontSubtitleLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value != null && value!.isNotEmpty ? value! : 'No especificado',
              style: textTheme.bodyMedium?.copyWith(
                color: valueColor,
                fontWeight: valueWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}