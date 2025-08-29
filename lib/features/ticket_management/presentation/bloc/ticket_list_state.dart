// lib/features/ticket_management/presentation/bloc/ticket_list_state.dart

part of 'ticket_list_bloc.dart';

abstract class TicketListState extends Equatable {
  const TicketListState();
  @override
  List<Object> get props => [];
}

class TicketListInitial extends TicketListState {}
class TicketListLoading extends TicketListState {}

class TicketListLoaded extends TicketListState {
  // Lista maestra con todos los boletos
  final List<TicketEntity> tickets;
  // Lista que se muestra en la UI después de aplicar filtros
  final List<TicketEntity> filteredTickets;

  const TicketListLoaded(this.tickets, this.filteredTickets);
  
  @override
  List<Object> get props => [tickets, filteredTickets];
}

class TicketListFailure extends TicketListState {
  final String message;
  const TicketListFailure(this.message);
  @override
  List<Object> get props => [message];
}