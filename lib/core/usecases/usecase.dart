import 'package:dartz/dartz.dart';
import '../error/failures.dart';

// Para poder usar el tipo Either, necesitamos añadir dartz
// flutter pub add dartz

/// ---
/// /// Clase abstracta [UseCase] que define el contrato estándar para los casos de uso
/// /// en la Arquitectura Limpia.
/// ///
/// /// Un caso de uso encapsula una lógica de negocio específica.
/// ///
/// /// [Type]: El tipo de dato que el caso de uso devolverá en caso de éxito.
/// /// [Params]: El tipo de dato para los parámetros que el caso de uso necesita.
/// ///          Se usa `void` si no se requieren parámetros.
/// ---
abstract class UseCase<Type, Params> {
  /// ---
  /// /// El método principal que ejecuta la lógica del caso de uso.
  /// ///
  /// /// Devuelve un [Future] que resuelve a un [Either].
  /// /// [Either] es un tipo funcional que puede contener un [Failure] (izquierda)
  /// /// o un valor de éxito [Type] (derecha). Esto fuerza el manejo explícito de errores.
  /// ///
  /// /// Parámetros:
  /// ///   - [params]: Los parámetros necesarios para ejecutar el caso de uso.
  /// ---
  Future<Either<Failure, Type>> call(Params params);
}