import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/client_entity.dart';
import '../../../domain/usecases/save_client_usecase.dart';

part 'client_creation_event.dart';
part 'client_creation_state.dart';

class ClientCreationBloc extends Bloc<ClientCreationEvent, ClientCreationState> {
  final SaveClientUseCase saveClientUseCase;

  ClientCreationBloc({required this.saveClientUseCase}) : super(ClientCreationInitial()) {
    on<SaveClientEvent>(_onSaveClient);
  }

  Future<void> _onSaveClient(SaveClientEvent event, Emitter<ClientCreationState> emit) async {
    emit(ClientCreationLoading());

    final newClient = ClientEntity(
      id: 0, // El ID es autogenerado por la BD, ponemos 0 como placeholder.
      name: event.name,
      lastName: event.lastName,
      email: event.email,
      phone: event.phone,
    );

    final result = await saveClientUseCase(newClient);

    result.fold(
      (failure) => emit(ClientCreationFailure(failure.message)),
      (_) => emit(ClientCreationSuccess()),
    );
  }
}