// lib/core/config/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import '../../features/client_management/client_management_injection.dart';
import '../../features/quotes/quotes_injection.dart' as quotes_di;
import '../../features/dashboard/dashboard_injection.dart';
import '../../features/ticket_import/ticket_import_injection.dart';
import '../../features/ticket_management/ticket_management_injection.dart';

/// ---
/// Instancia global del Service Locator [GetIt].
///
/// [sl] (service locator) se utilizará en toda la aplicación para obtener
/// instancias de clases registradas, como Repositorios, Casos de Uso, BLoCs, etc.
/// Esto desacopla las capas y facilita las pruebas.
/// ---
final sl = GetIt.instance;

/// ---
/// [init] es la función de inicialización para el service locator.
///
/// Aquí es donde se registrarán todas las dependencias de la aplicación.
/// Se llamará una sola vez al iniciar la app desde `main.dart`.
/// La organización de los registros se hará por feature.
/// ---
Future<void> init() async {
  // #######################################################################
  // # C O R E
  // #######################################################################

  /// Registra una instancia singleton de [Logger].
  ///
  /// [Logger] se utilizará para registrar información de depuración, advertencias
  /// y errores de una manera estructurada y legible en la consola.
  /// Se usa [LazySingleton] para que la instancia solo se cree cuando se
  /// necesite por primera vez.
  sl.registerLazySingleton(() => Logger(
        printer: PrettyPrinter(
          methodCount: 1,
          errorMethodCount: 5,
          lineLength: 80,
          colors: true,
          printEmojis: true,
          printTime: true,
        ),
      ));

  // #######################################################################
  // # F E A T U R E S
  // #######################################################################

  // Aquí registraremos las dependencias de cada feature.

  await initClientManagementFeature();
  await initTicketManagementFeature();
  await initDashboardFeature();
  await initTicketImportFeature();
  quotes_di.initQuotes();  
}