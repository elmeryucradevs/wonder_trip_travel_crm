
part of 'client_list_bloc.dart';


/// ---
/// [ClientListEvent] es la clase base para todos los eventos relacionados
/// con la lista de clientes.
///
/// Extiende [Equatable] para facilitar las pruebas y evitar la reconstrucción
/// innecesaria de widgets si el evento no ha cambiado.
/// ---
abstract class ClientListEvent extends Equatable {
  const ClientListEvent();

  @override
  List<Object> get props => [];
}

/// ---
/// Evento que se dispara para solicitar la carga de la lista de clientes.
///
/// La UI enviará este evento al BLoC cuando necesite mostrar los clientes
/// (por ejemplo, al entrar en la página).
/// ---
class FetchClientsEvent extends ClientListEvent {}

/// Evento que se dispara cuando el usuario escribe en el campo de búsqueda.
class SearchClient extends ClientListEvent {
  final String query;

  const SearchClient(this.query);

  @override
  List<Object> get props => [query];
}