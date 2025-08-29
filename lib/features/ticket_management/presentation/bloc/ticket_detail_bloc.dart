import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/delete_ticket_usecase.dart';

part 'ticket_detail_event.dart';
part 'ticket_detail_state.dart';

class TicketDetailBloc extends Bloc<TicketDetailEvent, TicketDetailState> {
  final DeleteTicketUseCase deleteTicketUseCase;

  TicketDetailBloc({required this.deleteTicketUseCase}) : super(TicketDetailInitial()) {
    on<DeleteTicketPressed>(_onDeleteTicket);
  }

  Future<void> _onDeleteTicket(DeleteTicketPressed event, Emitter<TicketDetailState> emit) async {
    emit(TicketDetailLoading());
    final result = await deleteTicketUseCase(event.ticketId);
    result.fold(
      (failure) => emit(TicketDetailFailure(failure.message)),
      (_) => emit(TicketDetailDeleteSuccess()),
    );
  }
}