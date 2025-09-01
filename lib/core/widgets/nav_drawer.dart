import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
            ),
            child: Text(
              'Wonder Trip CRM',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Dashboard'),
            onTap: () {
              // Navegamos usando el nombre de la ruta
              context.goNamed('dashboard');
              Navigator.pop(context); // Cierra el drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Clientes'),
            onTap: () {
              context.goNamed('clients');
              Navigator.pop(context);
            },
          ),
          // Aquí añadiremos enlaces a 'Boletos', 'Reportes', etc. en el futuro
        ],
      ),
    );
  }
}