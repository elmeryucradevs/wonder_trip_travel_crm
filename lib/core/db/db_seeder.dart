import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:wonder_trip_travel_crm/core/db/database.dart';

class DbSeeder {
  final AppDatabase _db;

  DbSeeder(this._db);

  Future<void> seed() async {
    // Verificamos si la tabla ya tiene datos para no re-insertar todo.
    final firstClient = await (_db.select(_db.clients)..limit(1)).getSingleOrNull();
    if (firstClient != null) {
      print("La base de datos ya ha sido poblada. No se requieren nuevas acciones.");
      return;
    }

    await _seedClients();
  }

  Future<void> _seedClients() async {
    // 1. Carga el archivo como bytes
    final byteData = await rootBundle.load('assets/DB_CLIENTES.csv');
    // 2. Decodifica los bytes usando latin1 (ISO-8859-1)
    final csvData = latin1.decode(byteData.buffer.asUint8List());
    // 3. Convierte los datos CSV en una lista de listas
    final List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvData);

    final Set<String> processedDocumentNumbers = {};

    // Skip header row
    for (var i = 1; i < csvTable.length; i++) {
      final row = csvTable[i];

      final documentNumber = row[0].toString().trim();

      // Si el número de documento está vacío o ya lo procesamos, lo saltamos.
      if (documentNumber.isEmpty || processedDocumentNumbers.contains(documentNumber)) {
        continue;
      }

      final fullName = row[2].toString().split(' ');
      final name = fullName.isNotEmpty ? fullName.first : '';
      final lastName = fullName.length > 1 ? fullName.sublist(1).join(' ') : '';

      final client = ClientsCompanion(
        documentNumber: Value(row[0].toString()),
        documentType: Value(row[1].toString()),
        name: Value(name),
        lastName: Value(lastName),
        phone: Value(row[3].toString()),
        birthDate: Value(_parseDate(row[4].toString())),
        email: Value(row[5].toString()),
        billingName: Value(row[6].toString()),
        billingDocument: Value(row[7].toString()),
        billingAddress: Value(row[8].toString()),
      );
      // Insertamos el cliente en la base de datos
      await _db.into(_db.clients).insert(client);
      // Añadimos el número de documento al set para no volver a procesarlo
      processedDocumentNumbers.add(documentNumber);
    }
     print("¡Migración de clientes completada con éxito!");
  }

  DateTime? _parseDate(String dateStr) {
    if (dateStr.isEmpty) return null;
    try {
      final parts = dateStr.split('/');
      if (parts.length != 3) return null;
      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);

      if (day == null || month == null || year == null) return null;
      
      // Validaciones básicas de fecha
      if (month > 12 || day > 31 || year < 1900) return null;

      return DateTime(year, month, day);
    } catch (e) {
      print("Error parseando la fecha: '$dateStr'");
      return null;
    }
  }
}