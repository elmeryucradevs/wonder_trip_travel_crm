import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder_trip_travel_crm/core/widgets/main_shell.dart';
import 'package:wonder_trip_travel_crm/features/client_management/presentation/pages/client_list_page.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/presentation/pages/dashboard_page.dart';

import '../../features/client_management/presentation/pages/client_creation_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/quotes/presentation/pages/quote_creation_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  // --- CAMBIO AQUÍ: Usamos un ShellRoute ---
  static GoRouter getRouter(String initialRoute) {
    return GoRouter(
      initialLocation: initialRoute,
      routes: [
        /// ShellRoute define la UI persistente (nuestro MainShell con el Drawer).
        /// Todas las rutas anidadas dentro de `routes` se mostrarán en el `child` del MainShell.
        ShellRoute(
          builder: (context, state, child) {
            return MainShell(child: child);
          },
          routes: [
            GoRoute(
              path: '/dashboard',
              name: 'dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
            GoRoute(
              path: '/clients',
              name: 'clients',
              builder: (context, state) => const ClientListPage(),
              routes: [
                GoRoute(
                  path: 'new', // Se accederá como /clients/new
                  name: 'newClient',
                  builder: (context, state) => const ClientCreationPage(),
                ),
              ],
            ),
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) => const SettingsPage(),
            ),
            GoRoute(
              path: '/onboarding',
              name: 'onboarding',
              builder: (context, state) => const OnboardingPage(),
            ),
            GoRoute(
              path: '/quotes/new',
              name: 'newQuote',
              builder: (context, state) => const QuoteCreationPage(),
            ),
          ],
        ),
        // Aquí podemos añadir rutas que NO usen el caparazón, como una pantalla de login.
      ],
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Error de Navegación')),
        body: Center(
          child: Text('Ruta no encontrada: ${state.error?.message}'),
        ),
      ),
    );
  }
}
