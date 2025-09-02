// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/app_router.dart';
import 'core/config/core_injection.dart';
import 'core/config/injection_container.dart' as di;
import 'core/db/database.dart';
import 'core/db/db_seeder.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'core/theme/theme.dart';
import 'features/onboarding/data/repositories/onboarding_repository.dart';

/// ---
/// [main] es el punto de entrada principal de la aplicación.
///
/// Se encarga de realizar las inicializaciones críticas antes de que la UI
/// sea renderizada.
///
/// Pasos que realiza:
/// 1. Asegura que los bindings de Flutter estén inicializados.
/// 2. Carga las variables de entorno desde el fichero .env.
/// 3. Inicializa el contenedor de inyección de dependencias (Service Locator).
/// 4. Ejecuta la aplicación principal [App].
/// ---
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await di.init();
  await initCore();

  // --- LÓGICA DE DECISIÓN DE RUTA INICIAL ---
  final onboardingRepo = di.sl<OnboardingRepository>();
  final hasSeenOnboarding = await onboardingRepo.hasSeenOnboarding();
  final initialRoute = hasSeenOnboarding ? '/dashboard' : '/onboarding';

  // Obtenemos la instancia de la BD y ejecutamos el seeder.
  await DbSeeder(di.sl<AppDatabase>()).seed();
  runApp(App(initialRoute: initialRoute));
}

/// ---
/// [App] es el widget raíz de la aplicación.
///
/// Es un [StatelessWidget] que configura el [MaterialApp] y proporciona
/// el contexto global para temas y BLoCs.
///
/// Configuración:
/// - [MultiBlocProvider]: Aunque actualmente está vacío, aquí se registrarán los BLoCs
///   que necesiten tener un alcance global en la aplicación.
/// - [MaterialApp]: Configura el tema, el soporte para modo oscuro y la
///   pantalla de inicio.
/// ---
class App extends StatelessWidget {
  final String initialRoute;
  const App({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Wonder Trip Travel CRM',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            routerConfig: AppRouter.getRouter(initialRoute),
          );
        },
      ),
    );
  }
}

/// ---
/// [PlaceholderScreen] es una pantalla temporal que sirve como punto de partida
/// visual mientras se desarrollan las funcionalidades principales.
///
/// Será reemplazada por el Splash Screen, Onboarding o la pantalla de inicio
/// de sesión según el estado del usuario.
/// ---
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRM - Wonder Trip Travel')),
      body: Center(
        child: Text(
          'Bienvenido al CRM',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
