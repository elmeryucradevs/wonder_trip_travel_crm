// lib/features/ticket_management/presentation/bloc/ticket_list_event.dart

part of 'ticket_list_bloc.dart';

abstract class TicketListEvent extends Equatable {
  const TicketListEvent();
  @override
  List<Object?> get props => [];
}

class FetchTicketsForClient extends TicketListEvent {
  final int clientId;
  const FetchTicketsForClient(this.clientId);
  @override
  List<Object> get props => [clientId];
}

// --- NUEVO EVENTO ---
class ApplyFiltersAndSearch extends TicketListEvent {
  final String searchQuery;
  final String status;
  final String type;
  final DateTimeRange? dateRange;

  const ApplyFiltersAndSearch({
    required this.searchQuery,
    required this.status,
    required this.type,
    this.dateRange,
  });

  @override
  List<Object?> get props => [searchQuery, status, type, dateRange];
}