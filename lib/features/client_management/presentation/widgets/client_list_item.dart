import 'package:flutter/material.dart';
import '../../domain/entities/client_entity.dart';

/// ---
/// /// [ClientListItem] es un widget reutilizable que muestra la información
/// /// resumida de un único cliente en una lista.
/// ///
/// /// Es un [StatelessWidget] que recibe un [ClientEntity] y lo presenta
/// /// de una manera visualmente atractiva y consistente con el tema de la app.
/// ///
/// /// Incluye:
/// /// - Un avatar con las iniciales del cliente.
/// /// - El nombre completo del cliente.
/// /// - El correo electrónico.
/// /// - Un botón para acciones futuras (ver detalles, editar, etc.).
/// ---
class ClientListItem extends StatelessWidget {
  final ClientEntity client;

  const ClientListItem({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initials = client.name.isNotEmpty ? client.name[0] : '';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          child: Text(initials),
        ),
        title: Text(client.fullName, style: theme.textTheme.titleMedium),
        subtitle: Text(
          client.email ?? 'Sin correo electrónico',
          style: theme.textTheme.bodySmall,
        ),
        trailing: Icon(Icons.chevron_right, color: theme.colorScheme.secondary),
        onTap: () {
          // TODO: Implementar navegación a la página de detalles del cliente (CRM-005)
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('Viendo detalles de ${client.fullName}')));
        },
      ),
    );
  }
}