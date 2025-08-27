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
  final String? email;
  final String? phone;
  final DateTime? birthDate;
  final String? documentNumber;
  final String? documentType;
  final String? travelerNumber;
  final String? billingName;
  final String? billingDocument;
  final String? billingAddress;

  const ClientEntity({
    required this.id,
    required this.name,
    required this.lastName,
    this.email,
    this.phone,
    this.birthDate,
    this.documentNumber,
    this.documentType,
    this.travelerNumber,
    this.billingName,
    this.billingDocument,
    this.billingAddress,
  });

  /// Devuelve el nombre completo del cliente.
  String get fullName => '$name $lastName';

  @override
  List<Object?> get props => [
        id,
        name,
        lastName,
        email,
        phone,
        birthDate,
        documentNumber,
        documentType,
        travelerNumber,
        billingName,
        billingDocument,
        billingAddress,
      ];
}