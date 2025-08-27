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
    on<UpdateClientEvent>(_onUpdateClient);
  }

  Future<void> _onSaveClient(SaveClientEvent event, Emitter<ClientCreationState> emit) async {
    emit(ClientCreationLoading());

    final newClient = ClientEntity(
      id: 0, //autogenerado por db 0 como placeholder
      name: event.name,
      lastName: event.lastName,
      email: event.email,
      phone: event.phone,
      documentNumber: event.documentNumber,
      documentType: event.documentType,
      travelerNumber: event.travelerNumber,
    );

    final result = await saveClientUseCase(newClient);

    result.fold(
      (failure) => emit(ClientCreationFailure(failure.message)),
      (_) => emit(ClientCreationSuccess()),
    );
  }

  Future<void> _onUpdateClient(
      UpdateClientEvent event, Emitter<ClientCreationState> emit) async {
    emit(ClientCreationLoading());
    final result = await saveClientUseCase(event.updatedClient);

    result.fold(
      (failure) => emit(ClientCreationFailure(failure.message)),
      (_) => emit(ClientCreationSuccess()),
    );
  }
}