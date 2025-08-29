import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../ticket_management/presentation/pages/ticket_list_page.dart';
import '../../domain/entities/client_entity.dart';
import '../bloc/client_detail/client_detail_bloc.dart';
import '../bloc/client_list_bloc.dart';
import 'client_edit_page.dart';

/// ---
/// [ClientDetailPage] Muestra toda la información de un cliente en un formato
/// de solo lectura. Sirve como un hub central para ver datos y acceder a
/// acciones como editar o eliminar.
/// ---
class ClientDetailPage extends StatelessWidget {
  final ClientEntity client;

  const ClientDetailPage({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ClientDetailBloc>(),
      child: BlocListener<ClientDetailBloc, ClientDetailState>(
        listener: (context, state) {
          if (state is ClientDetailDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cliente eliminado'), backgroundColor: Colors.orange),
            );
            // Refresca la lista y vuelve a la página principal.
            context.read<ClientListBloc>().add(FetchClientsEvent());
            Navigator.of(context).pop();
          } else if (state is ClientDetailFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}'), backgroundColor: Colors.red),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(client.fullName),
            actions: [
              // Usamos un Builder para obtener el context correcto para el BLoC
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () =>
                        _showDeleteConfirmationDialog(context, client.id),
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
                          clientId: client.id,
                          clientName: client.fullName,
                          client: client, 
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
                  _InfoRow(label: 'Nombre Completo', value: client.fullName),
                  _InfoRow(
                    label: 'Fecha de Nacimiento', 
                    value: client.birthDate != null 
                        ? DateFormat('dd/MM/yyyy').format(client.birthDate!) 
                        : null
                  ),
                  _InfoRow(label: 'Tipo Documento', value: client.documentType),
                  _InfoRow(label: 'Nº Documento', value: client.documentNumber),
                ]),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'Datos de Contacto y Viaje'),
                _buildInfoCard([
                  _InfoRow(label: 'Email', value: client.email),
                  _InfoRow(label: 'Teléfono', value: client.phone),
                  _InfoRow(
                    label: 'Nº Viajero Frecuente',
                    value: client.travelerNumber,
                  ),
                ]),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'Datos de Facturación'),
                _buildInfoCard([
                  _InfoRow(
                    label: 'Nombre o Razón Social',
                    value: client.billingName,
                  ),
                  _InfoRow(
                    label: 'NIT o Documento',
                    value: client.billingDocument,
                  ),
                  _InfoRow(label: 'Dirección', value: client.billingAddress),
                ]),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navegamos a la página de edición, pasando el BLoC de la lista
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<ClientListBloc>(),
                    child: ClientEditPage(client: client),
                  ),
                ),
              );
            },
            child: const Icon(Icons.edit),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int clientId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar este cliente? Esta acción no se puede deshacer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Eliminar'),
              onPressed: () {
                // Despacha el evento al BLoC usando el context de la página
                context.read<ClientDetailBloc>().add(DeleteClientRequested(clientId));
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
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

/// Widget auxiliar para mostrar una fila de información (etiqueta y valor)
class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120, // Ancho fijo para las etiquetas
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
        ],
      ),
    );
  }
}
