part of 'ticket_list_bloc.dart';

abstract class TicketListState extends Equatable {
  const TicketListState();
  @override
  List<Object> get props => [];
}

class TicketListInitial extends TicketListState {}
class TicketListLoading extends TicketListState {}
class TicketListLoaded extends TicketListState {
  final List<TicketEntity> tickets;
  const TicketListLoaded(this.tickets);
  @override
  List<Object> get props => [tickets];
}
class TicketListFailure extends TicketListState {
  final String message;
  const TicketListFailure(this.message);
  @override
  List<Object> get props => [message];
}