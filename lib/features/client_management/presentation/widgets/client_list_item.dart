import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';
import '../../domain/entities/client_entity.dart';
import '../bloc/client_list_bloc.dart';
import '../pages/client_edit_page.dart';

/// ---
/// [ClientListItem] es un widget rediseñado que muestra la información de un
/// cliente en una tarjeta moderna y espaciosa.
///
/// Abandona el ListTile por defecto para tener un control total sobre el diseño,
/// utilizando un layout de Columnas y Filas para organizar la información de
/// manera jerárquica y legible, siguiendo la nueva identidad visual.
/// ---
class ClientListItem extends StatelessWidget {
  final ClientEntity client;

  const ClientListItem({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                // Pasamos el ClientListBloc para poder refrescar la lista al volver.
                value: context.read<ClientListBloc>(),
                // Pasamos el cliente seleccionado a la página de edición.
                child: ClientEditPage(client: client),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Avatar con iniciales
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    client.name.isNotEmpty ? client.name[0].toUpperCase() : '?',
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Información del cliente
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.fullName,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.fontTitleLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Doc: ${client.documentNumber ?? "N/A"}',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.fontSubtitleLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Icono de acción
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.fontSubtitleLight,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}