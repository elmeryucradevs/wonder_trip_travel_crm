// lib/features/ticket_management/presentation/pages/ticket_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/presentation/pages/ticket_creation_page.dart';
import '../../../../core/config/injection_container.dart';
import '../../../client_management/domain/entities/client_entity.dart';
import '../bloc/ticket_list_bloc.dart';
import '../widgets/ticket_list_item.dart';

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
      child: Scaffold(
        appBar: AppBar(
          title: Text('Boletos de $clientName'),
        ),
        body: TicketListView(client: client), // Pasamos el cliente al ListView
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<TicketListBloc>(),
                        child: TicketCreationPage(client: client),
                      );
                    },
                  ),
                );
              },
              child: const Icon(Icons.add),
            );
          }
        ),
      ),
    );
  }
}

class TicketListView extends StatefulWidget {
  final ClientEntity client;
  const TicketListView({super.key, required this.client});

  @override
  State<TicketListView> createState() => _TicketListViewState();
}

class _TicketListViewState extends State<TicketListView> {
  final _searchController = TextEditingController();
  String _selectedStatus = 'Todos';
  String _selectedType = 'Todos';
  DateTimeRange? _selectedDateRange;

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
    _applyFilters();
  }

  void _applyFilters() {
    context.read<TicketListBloc>().add(
      ApplyFiltersAndSearch(
        searchQuery: _searchController.text,
        status: _selectedStatus,
        type: _selectedType,
        dateRange: _selectedDateRange,
      ),
    );
  }
  
  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedStatus = 'Todos';
      _selectedType = 'Todos';
      _selectedDateRange = null;
    });
    _applyFilters();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterSection(),
        Expanded(
          child: BlocBuilder<TicketListBloc, TicketListState>(
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
                if (state.filteredTickets.isEmpty) {
                   return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No se encontraron boletos con los filtros aplicados.', textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _clearFilters,
                            child: const Text('Limpiar Filtros'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: state.filteredTickets.length,
                  itemBuilder: (context, index) {
                    return TicketListItem(
                      ticket: state.filteredTickets[index],
                      client: widget.client,
                    );
                  },
                );
              } else if (state is TicketListFailure) {
                return Center(child: Text('Error al cargar boletos: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return ExpansionTile(
      title: const Text('Filtros y Búsqueda'),
      leading: const Icon(Icons.filter_list),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Buscar por PNR o Nº Boleto',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 16),
              _buildFilterChips<String>(
                label: 'Estado:',
                options: ['Todos', 'Confirmado', 'Cancelado', 'Reembolsado'],
                selectedValue: _selectedStatus,
                onSelected: (value) {
                  setState(() => _selectedStatus = value);
                  _applyFilters();
                },
              ),
              const SizedBox(height: 16),
               _buildFilterChips<String>(
                label: 'Tipo:',
                options: ['Todos', 'Original', 'Canje'],
                selectedValue: _selectedType,
                onSelected: (value) {
                  setState(() => _selectedType = value);
                   _applyFilters();
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    _selectedDateRange == null
                        ? 'Filtrar por fecha...'
                        : 'Fecha: ${DateFormat('dd/MM/yy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yy').format(_selectedDateRange!.end)}',
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                        initialDateRange: _selectedDateRange,
                      );
                      if (picked != null) {
                        setState(() => _selectedDateRange = picked);
                         _applyFilters();
                      }
                    },
                    child: const Text('Seleccionar'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: _clearFilters,
                  child: const Text('Limpiar todos los filtros'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips<T>(
      {required String label,
      required List<T> options,
      required T selectedValue,
      required ValueChanged<T> onSelected}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option.toString()),
              selected: selectedValue == option,
              onSelected: (selected) {
                if (selected) {
                  onSelected(option);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}