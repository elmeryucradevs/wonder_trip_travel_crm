import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../ticket_management/presentation/pages/ticket_list_page.dart';
import '../../domain/entities/client_entity.dart';
import '../bloc/client_detail/client_detail_bloc.dart';
import '../bloc/client_list_bloc.dart';
import 'client_edit_page.dart';

class ClientDetailPage extends StatefulWidget {
  final ClientEntity client;

  const ClientDetailPage({super.key, required this.client});

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  late ClientEntity _currentClient;

  @override
  void initState() {
    super.initState();
    _currentClient = widget.client;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ClientDetailBloc>(param1: _currentClient),
      child: BlocConsumer<ClientDetailBloc, ClientDetailState>(
        listener: (context, state) {
          if (state is ClientDetailDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cliente eliminado'), backgroundColor: Colors.orange),
            );
            context.read<ClientListBloc>().add(FetchClientsEvent());
            Navigator.of(context).pop();
          } else if (state is ClientDetailActionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}'), backgroundColor: Colors.red),
            );
          } else if (state is ClientDetailActionSuccess) {
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage), backgroundColor: Colors.green),
            );
          } else if (state is ClientDetailFailure) {
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}'), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is ClientDetailLoaded) {
            // Actualiza el cliente local si el estado del BLoC cambia
            _currentClient = state.client;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(_currentClient.fullName),
              actions: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () =>
                          _showDeleteConfirmationDialog(context, _currentClient.id),
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TicketListPage(
                              clientId: _currentClient.id,
                              clientName: _currentClient.fullName,
                              client: _currentClient, 
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.airplane_ticket_outlined),
                      label: const Text('Ver Boletos del Cliente'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentLight,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  _buildSectionTitle(context, 'Información Personal'),
                  _buildInfoCard([
                    _InfoRow(label: 'Nombre Completo', value: _currentClient.fullName),
                    _InfoRow(
                        label: 'Fecha de Nacimiento',
                        value: _currentClient.birthDate != null
                            ? DateFormat('dd/MM/yyyy').format(_currentClient.birthDate!)
                            : null),
                    _InfoRow(
                        label: 'Tipo Documento', value: _currentClient.documentType),
                    _InfoRow(
                        label: 'Nº Documento', value: _currentClient.documentNumber),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionTitle(context, 'Datos de Contacto y Viaje'),
                  _buildInfoCard([
                    _InfoRow(label: 'Email', value: _currentClient.email),
                    _InfoRow(
                      label: 'Teléfono',
                      value: _currentClient.phone,
                      trailing: _currentClient.phone != null &&
                              _currentClient.phone!.isNotEmpty
                          ? IconButton(
                              icon: const FaIcon(FontAwesomeIcons.whatsapp,
                                  color: Colors.green),
                              onPressed: () {
                                context.read<ClientDetailBloc>().add(
                                      OpenWhatsAppChatRequested(
                                          phoneNumber: _currentClient.phone!,
                                          client: _currentClient,
                                          ),
                                    );
                              },
                              tooltip: 'Enviar WhatsApp',
                              splashRadius: 24,
                            )
                          : null,
                    ),
                    _InfoRow(
                      label: 'Nº Viajero Frecuente',
                      value: _currentClient.travelerNumber,
                    ),
                  ]),
                  const SizedBox(height: 24),
                   _buildSectionTitle(context, 'Datos de Facturación'),
                    _buildInfoCard([
                      _InfoRow(
                        label: 'Nombre o Razón Social',
                        value: _currentClient.billingName,
                      ),
                      _InfoRow(
                        label: 'NIT o Documento',
                        value: _currentClient.billingDocument,
                      ),
                      _InfoRow(label: 'Dirección', value: _currentClient.billingAddress),
                    ]),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final updatedClient = await Navigator.of(context).push<ClientEntity>(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<ClientListBloc>(),
                      child: ClientEditPage(client: _currentClient),
                    ),
                  ),
                );
                if (updatedClient != null && mounted) {
                  setState(() {
                    _currentClient = updatedClient;
                  });
                }
              },
              child: const Icon(Icons.edit),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int clientId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text(
              '¿Estás seguro de que deseas eliminar este cliente? Esta acción no se puede deshacer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Eliminar'),
              onPressed: () {
                context.read<ClientDetailBloc>().add(DeleteClientRequested(clientId));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
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
  final Widget? trailing;

  const _InfoRow({required this.label, this.value, this.trailing});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
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
              value ?? 'No especificado',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.fontBodyLight,
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ]
        ],
      ),
    );
  }
}