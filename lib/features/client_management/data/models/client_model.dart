import '../../domain/entities/client_entity.dart';

/// ---
/// /// [ClientModel] es el Data Transfer Object (DTO) para la entidad [ClientEntity].
/// ///
/// /// Extiende [ClientEntity] para heredar sus propiedades, pero añade funcionalidades
/// /// específicas de la capa de datos, como la serialización/deserialización
/// /// desde/hacia JSON o cualquier otra fuente de datos.
/// ///
/// /// Esto mantiene la entidad de dominio limpia de dependencias externas.
/// ---
class ClientModel extends ClientEntity {
  const ClientModel({
    required super.id,
    required super.name,
    required super.lastName,
    super.email,
    super.phone,
    super.birthDate,
    super.documentNumber,
    super.documentType,
    super.travelerNumber,
    super.billingName,
    super.billingDocument,
    super.billingAddress,
  });

  /// ---
  /// /// [fromJson] es un factory constructor para crear una instancia de [ClientModel]
  /// /// a partir de un mapa (generalmente proveniente de una API JSON).
  /// ///
  /// /// Realiza la conversión de tipos y el manejo de valores nulos.
  /// ---
  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      documentNumber: json['documentNumber'],
      documentType: json['documentType'],
      travelerNumber: json['travelerNumber'],
      billingName: json['billingName'],
      billingDocument: json['billingDocument'],
      billingAddress: json['billingAddress'],
    );
  }

  /// ---
  /// /// [toJson] convierte la instancia de [ClientModel] a un mapa JSON.
  /// ///
  /// /// Es útil para enviar datos a una API en formato JSON.
  /// ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'birthDate': birthDate?.toIso8601String(),
      'documentNumber': documentNumber,
      'documentType': documentType,
      'travelerNumber': travelerNumber,
      'billingName': billingName,
      'billingDocument': billingDocument,
      'billingAddress': billingAddress,
    };
  }
}