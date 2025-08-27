import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/delete_client_usecase.dart';

part 'client_detail_event.dart';
part 'client_detail_state.dart';

class ClientDetailBloc extends Bloc<ClientDetailEvent, ClientDetailState> {
  final DeleteClientUseCase deleteClientUseCase;

  ClientDetailBloc({required this.deleteClientUseCase})
      : super(ClientDetailInitial()) {
    on<DeleteClientRequested>(_onDeleteClient);
  }

  Future<void> _onDeleteClient(
      DeleteClientRequested event, Emitter<ClientDetailState> emit) async {
    emit(ClientDetailLoading());
    final result = await deleteClientUseCase(event.clientId);
    result.fold(
      (failure) => emit(ClientDetailFailure(failure.message)),
      (_) => emit(ClientDetailDeleteSuccess()),
    );
  }
}