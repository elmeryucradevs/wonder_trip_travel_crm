part of 'ticket_form_bloc.dart';

abstract class TicketCreationState extends Equatable {
  const TicketCreationState();
  @override
  List<Object> get props => [];
}

class TicketCreationInitial extends TicketCreationState {}
class TicketCreationLoading extends TicketCreationState {}
class TicketCreationSuccess extends TicketCreationState {}
class TicketCreationFailure extends TicketCreationState {
  final String message;
  const TicketCreationFailure(this.message);
}