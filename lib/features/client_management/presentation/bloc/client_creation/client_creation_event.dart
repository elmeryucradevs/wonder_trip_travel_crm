part of 'client_creation_bloc.dart';

abstract class ClientCreationEvent extends Equatable {
  const ClientCreationEvent();
  @override
  List<Object?> get props => [];
}

/// Evento que se dispara cuando el usuario presiona "Guardar Cliente".
/// Contiene todos los datos necesarios del formulario.
class SaveClientEvent extends ClientCreationEvent {
  final String name;
  final String lastName;
  final String? email;
  final String? phone;
  final String documentNumber;
  final String? documentType;
  final DateTime? birthDate;
  final String? travelerNumber;
  final String? billingName;
  final String? billingDocument;
  final String? billingAddress;

  const SaveClientEvent({
    required this.name,
    required this.lastName,
    required this.documentNumber,
    this.email,
    this.phone,
    this.documentType,
    this.birthDate,
    this.travelerNumber,
    this.billingName,
    this.billingDocument,
    this.billingAddress,
  });

  @override
  List<Object?> get props => [
        name,
        lastName,
        birthDate,
        email,
        phone,
        documentNumber,
        documentType,
        travelerNumber,
        billingName,
        billingDocument,
        billingAddress,
      ];
}

class UpdateClientEvent extends ClientCreationEvent {
  final ClientEntity updatedClient;

  const UpdateClientEvent(this.updatedClient);

  @override
  List<Object?> get props => [updatedClient];
}