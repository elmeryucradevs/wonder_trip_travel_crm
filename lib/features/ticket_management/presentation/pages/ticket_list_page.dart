import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/presentation/pages/ticket_creation_page.dart';
import '../../../../core/config/injection_container.dart';
import '../../../client_management/domain/entities/client_entity.dart';
import '../bloc/ticket_list_bloc.dart';
import '../widgets/ticket_list_item.dart';

/// ---
/// /// [TicketListPage] es la pantalla que muestra una lista de boletos para un cliente específico.
/// ///
/// /// Recibe el [clientId] y el [clientName] para saber qué boletos buscar y
/// /// para mostrar un título contextual en la AppBar.
/// /// Utiliza [BlocProvider] para crear una instancia de [TicketListBloc] y
/// /// despacha el evento inicial para cargar los datos.
/// ---
class TicketListPage extends StatelessWidget {
  final int clientId;
  final String clientName;
  final ClientEntity client; 

  const TicketListPage({
    super.key,
    required this.clientId,
    required this.clientName,
    required this.client, 
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TicketListBloc>()..add(FetchTicketsForClient(clientId)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Boletos de $clientName'),
            ),
            body: BlocBuilder<TicketListBloc, TicketListState>(
              builder: (context, state) {
                if (state is TicketListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TicketListLoaded) {
                  if (state.tickets.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          'Este cliente no tiene boletos registrados.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }
                  // Usamos un ListView.separated para añadir espacio entre las tarjetas
                  return ListView.separated(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: state.tickets.length,
                    itemBuilder: (context, index) {
                      return TicketListItem(ticket: state.tickets[index]);
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 0),
                  );
                } else if (state is TicketListFailure) {
                  return Center(child: Text('Error al cargar boletos: ${state.message}'));
                }
                return const SizedBox.shrink(); // Estado inicial
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Al navegar, le pasamos el BLoC de la lista a la nueva ruta.
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      // 1. Usamos el `context` de la TicketListPage para leer el BLoC.
                      // 2. Usamos BlocProvider.value para proveer esa misma instancia a la nueva página.
                      return BlocProvider.value(
                        value: context.read<TicketListBloc>(),
                        child: TicketCreationPage(client: client),
                      );
                    },
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        }
      ),
    );
  }
}