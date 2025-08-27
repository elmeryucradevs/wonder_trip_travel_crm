part of 'client_creation_bloc.dart';

abstract class ClientCreationState extends Equatable {
  const ClientCreationState();
  @override
  List<Object> get props => [];
}

/// El estado inicial del formulario.
class ClientCreationInitial extends ClientCreationState {}

/// El estado mientras se está guardando el cliente en la base de datos.
class ClientCreationLoading extends ClientCreationState {}

/// El estado cuando el cliente se ha guardado con éxito.
class ClientCreationSuccess extends ClientCreationState {}

/// El estado cuando ha ocurrido un error al guardar.
class ClientCreationFailure extends ClientCreationState {
  final String message;
  const ClientCreationFailure(this.message);
  @override
  List<Object> get props => [message];
}