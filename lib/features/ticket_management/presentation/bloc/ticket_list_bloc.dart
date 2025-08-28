import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/usecases/get_tickets_for_client_usecase.dart';

part 'ticket_list_event.dart';
part 'ticket_list_state.dart';

class TicketListBloc extends Bloc<TicketListEvent, TicketListState> {
  final GetTicketsForClientUseCase getTicketsForClientUseCase;

  TicketListBloc({required this.getTicketsForClientUseCase}) : super(TicketListInitial()) {
    on<FetchTicketsForClient>(_onFetchTickets);
  }

  Future<void> _onFetchTickets(
      FetchTicketsForClient event, Emitter<TicketListState> emit) async {
    emit(TicketListLoading());
    final result = await getTicketsForClientUseCase(event.clientId);
    result.fold(
      (failure) => emit(TicketListFailure(failure.message)),
      (tickets) => emit(TicketListLoaded(tickets)),
    );
  }
}