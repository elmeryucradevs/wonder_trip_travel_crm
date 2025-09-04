import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/client_entity.dart';
import '../../../domain/usecases/delete_client_usecase.dart';
import '../../../domain/usecases/open_whatsapp_chat_usecase.dart';

part 'client_detail_event.dart';
part 'client_detail_state.dart';

class ClientDetailBloc extends Bloc<ClientDetailEvent, ClientDetailState> {
  final DeleteClientUseCase deleteClientUseCase;
  final OpenWhatsAppChatUseCase _openWhatsAppChatUseCase;

  ClientDetailBloc({
    required this.deleteClientUseCase,
    required OpenWhatsAppChatUseCase openWhatsAppChatUseCase,
    ClientEntity? client, // Parámetro opcional para el cliente inicial
  })  : _openWhatsAppChatUseCase = openWhatsAppChatUseCase,
        // Si se proporciona un cliente, el estado inicial es Loaded; si no, es Initial.
        super(client != null ? ClientDetailLoaded(client) : ClientDetailInitial()) {
    on<DeleteClientRequested>(_onDeleteClient);
    on<OpenWhatsAppChatRequested>(_onOpenWhatsAppChatRequested);
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

  Future<void> _onOpenWhatsAppChatRequested(
    OpenWhatsAppChatRequested event,
    Emitter<ClientDetailState> emit,
  ) async {
    final result = await _openWhatsAppChatUseCase(
      OpenWhatsAppChatParams(phoneNumber: event.phoneNumber),
    );

    result.fold(
      (failure) {
        emit(ClientDetailActionFailure(event.client, failure.message));
      },
      (_) {
        emit(ClientDetailActionSuccess(event.client, 'Iniciando conversación...'));
      },
    );
    // Regresamos al estado `Loaded` para que la UI se mantenga consistente
    // después de que el listener de la UI haya mostrado la notificación.
    emit(ClientDetailLoaded(event.client));
  }
}