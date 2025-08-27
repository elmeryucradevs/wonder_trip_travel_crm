import 'package:equatable/equatable.dart';

/// ---
/// /// [Failure] es una clase abstracta que sirve como base para todos los fallos
/// /// (errores controlados) en la capa de dominio de la aplicación.
/// ///
/// /// En lugar de lanzar excepciones a través de las capas, lo que puede ser difícil
/// /// de rastrear y manejar, devolvemos subtipos de [Failure]. Esto hace que los
/// /// errores sean explícitos y parte del contrato de un método.
/// ///
/// /// Extiende [Equatable] para permitir comparaciones de igualdad, lo que es útil
/// /// principalmente en las pruebas unitarias.
/// ---
abstract class Failure extends Equatable {
  /// /// El mensaje de error asociado con el fallo.
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// ---
/// /// Representa un fallo del lado del servidor (ej. error 500).
/// /// Se utiliza cuando una operación de red falla debido a un problema en el backend.
/// ---
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// ---
/// /// Representa un fallo en la caché o base de datos local (ej. no se pudieron guardar los datos).
/// /// Se utiliza cuando una operación en el almacenamiento local falla.
/// ---
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// ---
/// /// Representa un fallo de conexión de red (ej. sin internet).
/// /// Se utiliza cuando no se puede establecer comunicación con el servidor.
/// ---
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}