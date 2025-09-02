part of 'ticket_import_bloc.dart';

abstract class TicketImportEvent extends Equatable {
  const TicketImportEvent();
  @override
  List<Object> get props => [];
}

class PdfImportButtonPressed extends TicketImportEvent {}