part of 'ticket_import_bloc.dart';

abstract class TicketImportState extends Equatable {
  const TicketImportState();
  @override
  List<Object> get props => [];
}

class TicketImportInitial extends TicketImportState {}
class TicketImportLoading extends TicketImportState {}
class TicketImportSuccess extends TicketImportState {
  final ParsedTicketData  parsedData;
  const TicketImportSuccess(this.parsedData);
  @override
  List<Object> get props => [parsedData];
}
class TicketImportFailure extends TicketImportState {
  final String message;
  const TicketImportFailure(this.message);
  @override
  List<Object> get props => [message];
}