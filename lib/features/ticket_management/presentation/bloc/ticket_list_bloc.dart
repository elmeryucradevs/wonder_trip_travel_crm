// lib/features/ticket_management/presentation/bloc/ticket_list_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/usecases/get_tickets_for_client_usecase.dart';

part 'ticket_list_event.dart';
part 'ticket_list_state.dart';

class TicketListBloc extends Bloc<TicketListEvent, TicketListState> {
  final GetTicketsForClientUseCase getTicketsForClientUseCase;

  TicketListBloc({required this.getTicketsForClientUseCase}) : super(TicketListInitial()) {
    on<FetchTicketsForClient>(_onFetchTickets);
    on<ApplyFiltersAndSearch>(_onApplyFilters); // Registrar el nuevo manejador
  }

  Future<void> _onFetchTickets(
      FetchTicketsForClient event, Emitter<TicketListState> emit) async {
    emit(TicketListLoading());
    final result = await getTicketsForClientUseCase(event.clientId);
    result.fold(
      (failure) => emit(TicketListFailure(failure.message)),
      // Al cargar, la lista filtrada es igual a la lista completa
      (tickets) => emit(TicketListLoaded(tickets, tickets)),
    );
  }

  // --- NUEVO MÉTODO PARA FILTRAR ---
  void _onApplyFilters(ApplyFiltersAndSearch event, Emitter<TicketListState> emit) {
    // Solo podemos filtrar si ya tenemos la lista de boletos cargada
    final currentState = state;
    if (currentState is TicketListLoaded) {
      
      List<TicketEntity> filteredList = List.from(currentState.tickets);

      // 1. Filtrar por búsqueda de texto (PNR o Número de Boleto)
      if (event.searchQuery.isNotEmpty) {
        filteredList = filteredList.where((ticket) {
          final query = event.searchQuery.toLowerCase();
          final pnrMatch = ticket.pnr.toLowerCase().contains(query);
          final ticketNumMatch = ticket.ticketNumber?.toLowerCase().contains(query) ?? false;
          return pnrMatch || ticketNumMatch;
        }).toList();
      }

      // 2. Filtrar por estado
      if (event.status != 'Todos') {
        filteredList = filteredList.where((ticket) => ticket.status?.toLowerCase() == event.status.toLowerCase()).toList();
      }

      // 3. Filtrar por tipo (Original/Canje)
      if (event.type != 'Todos') {
        if (event.type == 'Original') {
          filteredList = filteredList.where((ticket) => ticket.originalTicketNumber == null || ticket.originalTicketNumber!.isEmpty).toList();
        } else { // Canje
          filteredList = filteredList.where((ticket) => ticket.originalTicketNumber != null && ticket.originalTicketNumber!.isNotEmpty).toList();
        }
      }

      // 4. Filtrar por rango de fechas (basado en la fecha de emisión)
      if (event.dateRange != null) {
        filteredList = filteredList.where((ticket) {
          final emissionDate = ticket.emissionDate;
          // Ajustamos el final del rango para incluir todo el día
          final endDate = event.dateRange!.end.add(const Duration(days: 1));
          return emissionDate.isAfter(event.dateRange!.start) && emissionDate.isBefore(endDate);
        }).toList();
      }

      // Emitimos el nuevo estado con la lista original y la lista ya filtrada
      emit(TicketListLoaded(currentState.tickets, filteredList));
    }
  }
}