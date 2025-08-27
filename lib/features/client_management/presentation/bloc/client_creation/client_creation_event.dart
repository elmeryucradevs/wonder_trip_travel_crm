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
  final String? travelerNumber;

  const SaveClientEvent({
    required this.name,
    required this.lastName,
    required this.documentNumber,
    this.email,
    this.phone,
    this.documentType,
    this.travelerNumber,
  });

  @override
  @override
  List<Object?> get props => [
        name,
        lastName,
        email,
        phone,
        documentNumber,
        documentType,
        travelerNumber,
      ];
}