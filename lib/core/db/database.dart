
import 'package:drift/drift.dart';

import '../../features/client_management/data/datasources/local/client_dao.dart';

import 'connection/native.dart'
    if (dart.library.html) 'connection/web.dart';

// Esto importa el fichero que será generado por drift.
// El nombre del fichero es el nombre de este fichero con la extensión ".g.dart"
part 'database.g.dart';

// --- TABLAS ---

/// ---
/// /// Define la tabla 'clients' para almacenar la información de los clientes.
/// ///
/// /// Esta tabla es el núcleo del CRM, conteniendo todos los datos personales
/// /// y de contacto de los clientes de la agencia.
/// ///
/// /// Campos:
/// /// - [id]: Clave primaria autoincremental.
/// /// - [name], [lastName]: Nombre y apellido del cliente.
/// /// - [email], [phone]: Información de contacto.
/// /// - [documentNumber]: Número de documento (CI, Pasaporte).
/// /// - [birthDate]: Fecha de nacimiento.
/// /// - [createdAt], [updatedAt]: Marcas de tiempo para auditoría.
/// ---
@DataClassName('Client')
class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get lastName => text().withLength(min: 1, max: 50)();
  TextColumn get email => text().unique()();
  TextColumn get phone => text().nullable()();
  TextColumn get documentNumber => text().nullable().unique()();
  DateTimeColumn get birthDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// ---
/// /// Define la tabla 'tickets' para los boletos aéreos emitidos.
/// ///
/// /// Almacena información clave sobre cada boleto, vinculándolo a un cliente.
/// ///
/// /// Campos:
/// /// - [clientId]: Clave foránea que referencia a la tabla 'clients'.
/// /// - [pnr]: Código de reserva de la aerolínea.
/// /// - [totalPrice]: Precio total del boleto.
/// ---
@DataClassName('Ticket')
class Tickets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  TextColumn get pnr => text().withLength(min: 6, max: 6)();
  RealColumn get totalPrice => real()();
  DateTimeColumn get emissionDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// ---
/// /// Define la tabla 'flight_segments' para los tramos de un vuelo.
/// ///
/// /// Un boleto puede consistir en múltiples segmentos de vuelo.
/// ///
/// /// Campos:
/// /// - [ticketId]: Clave foránea que referencia a la tabla 'tickets'.
/// /// - [airlineCode], [flightNumber]: Identificadores del vuelo.
/// /// - [origin], [destination]: Códigos IATA de los aeropuertos.
/// /// - [departureDate], [arrivalDate]: Fechas y horas del segmento.
/// ---
@DataClassName('FlightSegment')
class FlightSegments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ticketId => integer().references(Tickets, #id)();
  TextColumn get airlineCode => text().withLength(min: 2, max: 3)();
  TextColumn get flightNumber => text()();
  TextColumn get origin => text().withLength(min: 3, max: 3)();
  TextColumn get destination => text().withLength(min: 3, max: 3)();
  DateTimeColumn get departureDate => dateTime()();
  DateTimeColumn get arrivalDate => dateTime()();
}


/// ---
/// /// [AppDatabase] es la clase principal que gestiona la base de datos de la aplicación.
/// ///
/// /// Utiliza el decorador [@DriftDatabase] para indicar a `drift_dev` que genere
/// /// el código necesario para las tablas y DAOs (Data Access Objects) especificados.
/// ///
/// /// La clase extiende la clase generada `_$AppDatabase` que contiene la implementación
/// /// real de la lógica de la base de datos.
/// ///
/// /// Incluye las tablas: [Clients], [Tickets], [FlightSegments].
/// /// Incluye los DAOs: [ClientDao], [TicketDao] (se crearán más adelante).
/// ---
/// /// Se añade el DAO [ClientDao] a la lista de 'daos' en el decorador.
/// /// Drift ahora generará el código necesario para que AppDatabase pueda
/// /// instanciar y proporcionar el ClientDao.
/// ---
@DriftDatabase(tables: [Clients, Tickets, FlightSegments], daos: [ClientDao])
class AppDatabase extends _$AppDatabase {
  /// El constructor ahora llama a la función `connect()` que importamos
  /// condicionalmente. Dart se encargará de llamar a la versión nativa o web.
  AppDatabase() : super(connect());

  @override
  int get schemaVersion => 1;
}

/// ---
/// /// [_openConnection] es una función privada que configura la conexión a la
/// /// base de datos SQLite.
/// ///
/// /// Determina la ubicación del fichero de la base de datos en el directorio de
/// /// documentos de la aplicación y crea una conexión [NativeDatabase].
/// ---
