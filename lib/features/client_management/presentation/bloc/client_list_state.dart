part of 'client_list_bloc.dart';

/// ---
/// [ClientListState] es la clase base para los estados de la pantalla de lista de clientes.
///
/// Extiende [Equatable] para que el [BlocBuilder] pueda comparar eficientemente
/// el estado anterior y el nuevo, y solo reconstruir la UI si el estado ha cambiado.
/// ---
abstract class ClientListState extends Equatable {
  const ClientListState();

  @override
  List<Object> get props => [];
}

/// El estado inicial, antes de que se haya realizado cualquier acción.
class ClientListInitial extends ClientListState {}

/// Estado que indica que la lista de clientes se está cargando. La UI mostrará un spinner.
class ClientListLoading extends ClientListState {}

/// Estado que indica que la lista de clientes se cargó exitosamente. Contiene la lista de clientes.
class ClientListLoaded extends ClientListState {
  final List<ClientEntity> clients;
  final List<ClientEntity> filteredClients;

  const ClientListLoaded(this.clients, this.filteredClients);

  @override
  List<Object> get props => [clients,filteredClients];
}

/// Estado que indica que ocurrió un error al cargar la lista. Contiene el mensaje de error.
class ClientListError extends ClientListState {
  final String message;

  const ClientListError(this.message);

  @override
  List<Object> get props => [message];
}