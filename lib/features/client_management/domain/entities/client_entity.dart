import 'package:equatable/equatable.dart';

/// ---
/// /// [ClientEntity] representa el modelo de negocio principal de un cliente.
/// ///
/// /// Esta es una clase pura de Dart que no contiene lógica de serialización
/// /// ni dependencias de frameworks externos. Representa la información esencial
/// /// de un cliente dentro de la capa de dominio.
/// ///
/// /// Extiende [Equatable] para permitir comparaciones de objetos por valor, lo cual
/// /// es muy útil para pruebas y para la lógica de estado en BLoC.
/// ---
class ClientEntity extends Equatable {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String? phone;
  final DateTime? birthDate;

  const ClientEntity({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    this.phone,
    this.birthDate,
  });

  /// Devuelve el nombre completo del cliente.
  String get fullName => '$name $lastName';

  @override
  List<Object?> get props => [id, name, lastName, email, phone, birthDate];
}