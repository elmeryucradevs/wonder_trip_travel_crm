part of 'client_detail_bloc.dart';

abstract class ClientDetailState extends Equatable {
  const ClientDetailState();
  @override
  List<Object> get props => [];
}

class ClientDetailInitial extends ClientDetailState {}
class ClientDetailLoading extends ClientDetailState {}
class ClientDetailDeleteSuccess extends ClientDetailState {}
class ClientDetailFailure extends ClientDetailState {
  final String message;
  const ClientDetailFailure(this.message);
  @override
  List<Object> get props => [message];
}

class ClientDetailLoaded extends ClientDetailState {
  final ClientEntity client;
  const ClientDetailLoaded(this.client);
  @override
  List<Object> get props => [client];
}

/// {@template client_detail_action_failure}
/// Estado que representa un fallo al ejecutar una acción en la vista de detalle.
/// Mantiene los datos del cliente para que la UI no pierda la información.
/// {@endtemplate}
class ClientDetailActionFailure extends ClientDetailLoaded {
  final String errorMessage;
  const ClientDetailActionFailure(super.client, this.errorMessage);
  @override
  List<Object> get props => [client, errorMessage];
}

/// {@template client_detail_action_success}
/// Estado que representa el éxito al ejecutar una acción.
/// {@endtemplate}
class ClientDetailActionSuccess extends ClientDetailLoaded {
  final String successMessage;
  const ClientDetailActionSuccess(super.client, this.successMessage);
  @override
  List<Object> get props => [client, successMessage];
}