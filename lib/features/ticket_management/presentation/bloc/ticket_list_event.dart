part of 'ticket_list_bloc.dart';

abstract class TicketListEvent extends Equatable {
  const TicketListEvent();
  @override
  List<Object> get props => [];
}

class FetchTicketsForClient extends TicketListEvent {
  final int clientId;
  const FetchTicketsForClient(this.clientId);
  @override
  List<Object> get props => [clientId];
}