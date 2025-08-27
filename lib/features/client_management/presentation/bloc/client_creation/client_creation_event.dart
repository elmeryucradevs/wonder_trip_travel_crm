part of 'client_creation_bloc.dart';

abstract class ClientCreationEvent extends Equatable {
  const ClientCreationEvent();
  @override
  List<Object> get props => [];
}

/// Evento que se dispara cuando el usuario presiona "Guardar Cliente".
/// Contiene todos los datos necesarios del formulario.
class SaveClientEvent extends ClientCreationEvent {
  final String name;
  final String lastName;
  final String email;
  final String? phone;

  const SaveClientEvent({
    required this.name,
    required this.lastName,
    required this.email,
    this.phone,
  });

  @override
  List<Object> get props => [name, lastName, email];
}