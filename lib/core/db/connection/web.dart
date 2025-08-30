import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

/// ---
/// [connect] es la función que configura la conexión para la web, utilizando
/// el método moderno basado en WebAssembly (WASM).
///
/// 1. Abre la base de datos WASM (`WasmDatabase.open`).
/// 2. Especifica el nombre de la base de datos en IndexedDB.
/// 3. Proporciona las URIs a los ficheros `sqlite3.wasm` y `drift_worker.js`
///    que copiamos a nuestra carpeta `web/`.
/// ---
LazyDatabase connect() {
  return LazyDatabase(() async {
    final result = await WasmDatabase.open(
      databaseName: 'wonder-trip-crm-db',
      // Apuntamos a los ficheros que build_runner va a generar y servir.
      // Drift es lo suficientemente inteligente como para encontrar sqlite3.wasm
      // sin una ruta explícita cuando se usa esta configuración.
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );

    if (result.missingFeatures.isNotEmpty) {
      print('Using ${result.chosenImplementation} due to missing browser '
          'features: ${result.missingFeatures}');
    }

    return result.resolvedExecutor;
  });
}