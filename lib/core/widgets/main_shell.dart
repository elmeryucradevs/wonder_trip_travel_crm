import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder_trip_travel_crm/core/widgets/nav_drawer.dart';

/// ---
/// /// [MainShell] es el widget principal que define la estructura visual
/// /// persistente de la aplicación (el "caparazón").
/// ///
/// /// Contiene el Scaffold, AppBar y el NavDrawer. Las diferentes páginas de la
/// /// aplicación se renderizan dentro del `body` de este Scaffold a través
/// /// de un `ShellRoute` de go_router.
/// ///
/// /// El parámetro [child] es el widget de la ruta activa que go_router nos proporciona.
/// ---
class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getPageTitle(context)),
      ),
      drawer: const NavDrawer(), // <-- AQUÍ INSERTAMOS EL NAV_DRAWER
      body: child,
    );
  }

  /// Helper para obtener el título de la página basado en la ruta actual.
  String _getPageTitle(BuildContext context) {
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    if (location.startsWith('/clients')) {
      return 'Clientes';
    }
    // Añade más casos para otras rutas aquí
    return 'Dashboard'; // Título por defecto
  }
}