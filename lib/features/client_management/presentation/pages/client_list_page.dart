import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/injection_container.dart';
import '../bloc/client_list_bloc.dart';
import '../widgets/client_list_item.dart';

/// ---
/// [ClientListPage] es la pantalla principal para mostrar la lista de clientes.
///
/// Es un [StatelessWidget] que utiliza [BlocProvider] para crear e inyectar
/// una instancia de [ClientListBloc] en el árbol de widgets.
/// El [ClientListView] es el encargado de construir la UI basada en el estado del BLoC.
/// ---
class ClientListPage extends StatelessWidget {
  const ClientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ClientListBloc>()..add(FetchClientsEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: const ClientListView(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Usamos go_router en lugar de Navigator.push ---
                context.goNamed('newClient');
              },
              child: const Icon(Icons.add),
            ),
          );
        }
      ),
    );
  }
}

/// ---
/// [ClientListView] es el widget que realmente construye la UI de la lista.
///
/// Utiliza [BlocBuilder] para escuchar los cambios de estado de [ClientListBloc]
/// y reconstruir la UI en consecuencia.
///
/// Maneja los cuatro estados posibles:
/// - [ClientListLoading]: Muestra un [CircularProgressIndicator].
/// - [ClientListLoaded]: Muestra un [ListView] con los clientes.
/// - [ClientListError]: Muestra un mensaje de error.
/// - Otro estado (inicial): Muestra un contenedor vacío.
/// ---
class ClientListView extends StatefulWidget {
  const ClientListView({super.key});

  @override
  State<ClientListView> createState() => _ClientListViewState();
}

class _ClientListViewState extends State<ClientListView> {

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    context.read<ClientListBloc>().add(SearchClient(_searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Buscar por nombre, documento, etc.',
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<ClientListBloc, ClientListState>(
            builder: (context, state) {
              if (state is ClientListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ClientListLoaded) {
                if (state.clients.isEmpty) {
                  return const Center(child: Text('No hay clientes registrados.'));
                }
                if (state.filteredClients.isEmpty) {
                  return const Center(
                      child: Text('No se encontraron clientes.'));
                }
                return ListView.builder(
                  itemCount: state.filteredClients.length,
                  itemBuilder: (context, index) {
                    final client = state.filteredClients[index];
                    return ClientListItem(client: client);
                  },
                );
              } else if (state is ClientListError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '${state.message}\n\nPor favor, intente de nuevo.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink(); // Estado inicial o no manejado
            },
          ),
        ),
      ],
    );
  }
}