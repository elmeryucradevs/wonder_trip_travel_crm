// lib/core/db/database.dart

import 'package:drift/drift.dart';

import '../../features/client_management/data/datasources/local/client_dao.dart';

import 'connection/native.dart'
    if (dart.library.html) 'connection/web.dart';
import 'dao/ticket_dao.dart';
import '../../features/ticket_management/domain/entities/ticket_entity.dart';

part 'database.g.dart';

// --- TABLAS ---

/// ---
/// Define la tabla 'clients' para almacenar la información de los clientes.
///
/// Esta tabla es el núcleo del CRM, conteniendo todos los datos personales
/// y de contacto de los clientes de la agencia.
///
/// Campos:
/// - [id]: Clave primaria autoincremental.
/// - [name], [lastName]: Nombre y apellido del cliente.
/// - [email], [phone]: Información de contacto.
/// - [documentNumber]: Número de documento (CI, Pasaporte).
/// - [birthDate]: Fecha de nacimiento.
/// - [createdAt], [updatedAt]: Marcas de tiempo para auditoría.
/// ---
@DataClassName('Client')
class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get lastName => text().withLength(min: 1, max: 50)();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get documentType => text().withLength(min: 2, max: 10).nullable()();
  TextColumn get documentNumber => text().nullable().unique()();
  DateTimeColumn get birthDate => dateTime().nullable()();
  TextColumn get travelerNumber => text().nullable()(); 
  TextColumn get billingName => text().nullable()();
  TextColumn get billingDocument => text().nullable()();
  TextColumn get billingAddress => text().nullable()();

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
  DateTimeColumn get emissionDate => dateTime()();
  /// Tipo de transporte: 'AEREO' o 'TERRESTRE'.
  TextColumn get transportType => text().withLength(min: 5, max: 10).withDefault(const Constant('AEREO'))();
  
  /// Número de boleto completo.
  TextColumn get ticketNumber => text().nullable()();

  /// Tipo de Vuelo: OW (One-Way) o RT (Round-Trip).
  TextColumn get flightType => text().withLength(min: 2, max: 2).nullable()();

  /// Categoría del Pasajero: ADT (Adulto), CHD (Niño), INF (Infante), SNN (Adulto Mayor).
  TextColumn get passengerCategory => text().withLength(min: 3, max: 3).nullable()();
  
  /// NUEVO: Indica si el menor viaja solo.
  BoolColumn get unaccompaniedMinor => boolean().nullable()();

  /// Proveedor o agente que emitió el boleto.
  TextColumn get issuingAgent => text().nullable()();
  
  /// Estado del boleto: CONFIRMADO, CANCELADO, REEMBOLSADO.
  TextColumn get status => text().nullable()();

  // --- DESGLOSE DE TARIFAS ---
  TextColumn get currency => text().withLength(min: 3, max: 3).withDefault(const Constant('USD'))();
  RealColumn get totalPrice => real()();

  /// La comisión que recibe la agencia por la venta de este boleto.
  RealColumn get commission => real().nullable()();

  /// Si este boleto fue emitido por un cambio, aquí se guarda el ID del boleto original.
  IntColumn get originalTicketId => integer().nullable().references(Tickets, #id)();

  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
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
  // --- CLAVE FORÁNEA PARA RELACIONAR CON UN TICKET ---
  IntColumn get ticketId => integer().references(Tickets, #id)();

  // --- CAMPOS ESPECÍFICOS DE LA RUTA ---
  TextColumn get airlineCode => text().withLength(min: 2, max: 3).nullable()();
  TextColumn get flightNumber => text().nullable()();
  TextColumn get origin => text().withLength(min: 3, max: 3)();
  TextColumn get destination => text().withLength(min: 3, max: 3)();
  DateTimeColumn get departureDate => dateTime()();
  DateTimeColumn get arrivalDate => dateTime()();

  TextColumn get flightClass => text().withLength(min: 1, max: 20).nullable()();
  
  // Para registrar escalas en el futuro
  TextColumn get stopover => text().nullable()(); 
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
@DriftDatabase(
  tables: [Clients, Tickets, FlightSegments],
  daos: [ClientDao, TicketDao],) 
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