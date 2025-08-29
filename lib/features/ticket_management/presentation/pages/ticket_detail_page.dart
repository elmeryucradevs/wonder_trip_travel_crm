// lib/features/ticket_management/presentation/pages/ticket_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/ticket_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/presentation/bloc/ticket_list_bloc.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/presentation/pages/ticket_edit_page.dart';

import '../../../../core/config/injection_container.dart';
import '../bloc/ticket_detail_bloc.dart';
import '../bloc/ticket_form_bloc.dart';
import '../widgets/flight_timeline_widget.dart';
import 'ticket_creation_page.dart';

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
    return BlocProvider(
      create: (context) => sl<TicketDetailBloc>(),
      child: BlocListener<TicketDetailBloc, TicketDetailState>(
        listener: (context, state) {
          if (state is TicketDetailDeleteSuccess) {
            context.read<TicketListBloc>().add(FetchTicketsForClient(widget.client.id));
            // Usamos popUntil para volver a la lista de clientes, no solo a la de boletos.
            //Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context)..pop()..pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Boleto eliminado con éxito'), backgroundColor: Colors.orange),
            );
          } else if (state is TicketDetailFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error al eliminar: ${state.message}'), backgroundColor: Colors.red),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Detalles PNR: ${_currentTicket.pnr}'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () async {
                  // --- LÓGICA DE REFRESCO ---
                  // Navegamos y ESPERAMOS un resultado de la página de edición.
                  final updatedTicket = await Navigator.of(context)
                      .push<TicketEntity>(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<TicketListBloc>(),
                            child: TicketEditPage(
                              ticket: _currentTicket,
                              client: widget.client,
                            ),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Boleto actualizado con éxito'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              ),
              Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () => _showDeleteConfirmationDialog(context, widget.ticket.id),
                );
              }),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildExchangeButton(context),
                const SizedBox(height: 16),
                _buildDetailsCard(context, 'Información General', [
                  _buildTicketDetailItem('PNR / Código', _currentTicket.pnr),
                  _buildTicketDetailItem('Nº de Boleto:', _currentTicket.ticketNumber ?? 'No especificado'),
                  if (_currentTicket.originalTicketNumber != null && _currentTicket.originalTicketNumber!.isNotEmpty)
                  _buildTicketDetailItem('Boleto de Canje:', 'Reemplaza a: ${_currentTicket.originalTicketNumber!}'),
                  _buildTicketDetailItem(
                    'Tipo de Viaje',
                    _currentTicket.flightType == 'RT'
                        ? 'Ida y Vuelta'
                        : 'Solo Ida',
                  ),
                  _buildTicketDetailItem(
                    'Proveedor',
                    _currentTicket.issuingAgent ?? 'N/A',
                  ),
                  _buildTicketDetailItem(
                    'Fecha de Emisión',
                    DateFormat(
                      'dd/MM/yyyy HH:mm',
                    ).format(_currentTicket.emissionDate),
                  ),
                  _buildTicketDetailItem(
                    'Tipo de Transporte',
                    _currentTicket.transportType.name.toUpperCase(),
                  ),
                  _buildTicketDetailItem(
                    'Categoría Pasajero',
                    _currentTicket.passengerCategory ?? 'N/A',
                  ),
                  // --- LÓGICA MEJORADA ---
                  // Si es un niño, siempre mostramos su estado de acompañamiento.
                  if (_currentTicket.passengerCategory == 'CHD')
                    _buildTicketDetailItem(
                      'Menor No Acompañado',
                      _currentTicket.unaccompaniedMinor == true ? 'Sí' : 'No',
                    ),
                  _buildTicketDetailItem(
                    'Estado',
                    _currentTicket.status ?? 'N/A',
                  ),
                ]),
                const SizedBox(height: 16),
                _buildDetailsCard(context, 'Detalles de Precios', [
                  _buildTicketDetailItem(
                    'Precio Total',
                    '${_currentTicket.totalPrice.toStringAsFixed(2)} ${_currentTicket.currency}',
                  ),
                  _buildTicketDetailItem(
                    'Comisión',
                    _currentTicket.commission != null
                        ? '${_currentTicket.commission!.toStringAsFixed(2)} ${_currentTicket.currency}'
                        : 'N/A',
                  ),
                ]),
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
        ),
      ),
    );
  }

  Widget _buildDetailsCard(
    BuildContext context,
    String title,
    List<Widget> items,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
  
  Widget _buildExchangeButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: context.read<TicketListBloc>()),
                // Creamos una nueva instancia del BLoC de formulario para el nuevo boleto
                BlocProvider(create: (_) => sl<TicketFormBloc>()),
              ],
              child: TicketCreationPage(
                client: widget.client,
                originalTicketNumber: widget.ticket.ticketNumber, // Pasamos el ID del boleto actual
              ),
            ),
          ),
        );
      },
      icon: const Icon(Icons.sync_alt),
      label: const Text('Registrar Canje / Cambio'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight.withOpacity(0.8),
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int ticketId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text(
            '¿Estás seguro de que deseas eliminar este boleto y todos sus segmentos? Esta acción no se puede deshacer.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Eliminar'),
              onPressed: () {
                context.read<TicketDetailBloc>().add(
                  DeleteTicketPressed(ticketId),
                );
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
