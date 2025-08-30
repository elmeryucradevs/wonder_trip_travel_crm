import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

/// ---
/// [connect] es la función que configura la conexión para plataformas nativas.
///
/// Determina la ubicación del fichero de la base de datos en el directorio de
/// documentos de la aplicación y crea una conexión [NativeDatabase].
/// ---
LazyDatabase connect() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Esta línea es importante en algunas plataformas nativas para asegurar
    // que la librería SQLite3 correcta esté disponible.
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase.createInBackground(file);
  });
}