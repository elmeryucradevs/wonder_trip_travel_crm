/// ---
/// /// [ServerException] se lanza cuando ocurre un error durante una llamada a una API
/// /// o cualquier otra operación del lado del servidor.
/// ///
/// /// Este tipo de excepción es capturada en la capa de Datos y típicamente se
/// /// transforma en un [ServerFailure] en la capa de Dominio.
/// ---
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

/// ---
/// /// [CacheException] se lanza cuando hay un problema al interactuar con
/// /// el almacenamiento local (base de datos, shared preferences, etc.).
/// ///
/// /// Es capturada en la capa de Datos y se transforma en un [CacheFailure].
/// ---
class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}