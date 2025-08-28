// lib/features/ticket_management/presentation/pages/ticket_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/ticket_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/presentation/bloc/ticket_list_bloc.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/presentation/pages/ticket_edit_page.dart';

import '../widgets/flight_timeline_widget.dart';

class TicketDetailPage extends StatefulWidget {
  final TicketEntity ticket;
  final ClientEntity client;

  const TicketDetailPage({
    super.key,
    required this.ticket,
    required this.client,
  });

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  late TicketEntity _currentTicket;

  @override
  void initState() {
    super.initState();
    _currentTicket = widget.ticket;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Boleto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () async {
              // --- LÓGICA DE REFRESCO ---
              // Navegamos y ESPERAMOS un resultado de la página de edición.
              final updatedTicket = await Navigator.of(context).push<TicketEntity>(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<TicketListBloc>(),
                    child: TicketEditPage(ticket: _currentTicket, client: widget.client),
                  ),
                ),
              );

              // Si recibimos un boleto actualizado, refrescamos el estado.
              if (updatedTicket != null && mounted) {

                // 1. Refresca el estado de la UI con los nuevos datos.
                setState(() {
                  _currentTicket = updatedTicket;
                });
                
                // 2. Muestra la notificación de éxito aquí.
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Boleto actualizado con éxito'),
                  backgroundColor: Colors.green,
                ));
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDetailsCard(
              context,
              'Información General',
              [
                _buildTicketDetailItem('PNR / Código', _currentTicket.pnr),
                _buildTicketDetailItem('Tipo de Viaje',
                    _currentTicket.flightType == 'RT' ? 'Ida y Vuelta' : 'Solo Ida'),
                _buildTicketDetailItem(
                    'Proveedor', _currentTicket.issuingAgent ?? 'N/A'),
                _buildTicketDetailItem('Fecha de Emisión',
                    DateFormat('dd/MM/yyyy HH:mm').format(_currentTicket.emissionDate)),
                _buildTicketDetailItem(
                    'Tipo de Transporte', _currentTicket.transportType.name.toUpperCase()),
                _buildTicketDetailItem(
                    'Categoría Pasajero', _currentTicket.passengerCategory ?? 'N/A'),
                // --- LÓGICA MEJORADA ---
                // Si es un niño, siempre mostramos su estado de acompañamiento.
                if (_currentTicket.passengerCategory == 'CHD')
                  _buildTicketDetailItem('Menor No Acompañado',
                      _currentTicket.unaccompaniedMinor == true ? 'Sí' : 'No'),
                _buildTicketDetailItem('Estado', _currentTicket.status ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailsCard(
              context,
              'Detalles de Precios',
              [
                _buildTicketDetailItem('Precio Total',
                    '${_currentTicket.totalPrice.toStringAsFixed(2)} ${_currentTicket.currency}'),
                _buildTicketDetailItem(
                    'Comisión',
                    _currentTicket.commission != null
                        ? '${_currentTicket.commission!.toStringAsFixed(2)} ${_currentTicket.currency}'
                        : 'N/A'),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                'Itinerario de Vuelo',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.fontTitleLight,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            FlightTimeline(segments: _currentTicket.segments),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(
      BuildContext context, String title, List<Widget> items) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.fontTitleLight,
                  ),
            ),
            const Divider(height: 24),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildTicketDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}