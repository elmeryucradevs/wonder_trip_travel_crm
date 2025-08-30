import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/config/injection_container.dart';
import '../../domain/entities/client_entity.dart';
import '../../domain/usecases/get_all_clients_usecase.dart';
import 'package:logger/logger.dart';

part 'client_list_event.dart';
part 'client_list_state.dart';

/// ---
/// [ClientListBloc] gestiona el estado de la pantalla de la lista de clientes.
///
/// Escucha los [ClientListEvent]s, ejecuta el caso de uso correspondiente
/// ([GetAllClientsUseCase]), y emite [ClientListState]s en respuesta, que
/// son consumidos por la UI para actualizarse.
/// ---
class ClientListBloc extends Bloc<ClientListEvent, ClientListState> {
  final GetAllClientsUseCase getAllClients;
  final Logger logger = sl<Logger>();

  /// El constructor requiere el caso de uso [GetAllClientsUseCase].
  ///
  /// El estado inicial se establece en [ClientListInitial].
  /// Se registra un manejador de eventos para [FetchClientsEvent].
  ClientListBloc({required this.getAllClients}) : super(ClientListInitial()) {
    on<FetchClientsEvent>(_onFetchClients);
  }

  /// ---
  /// Manejador para el evento [FetchClientsEvent].
  ///
  /// Este método se ejecuta cuando la UI despacha un [FetchClientsEvent].
  ///
  /// Lógica:
  /// 1. Emite [ClientListLoading] para notificar a la UI que muestre un indicador de carga.
  /// 2. Llama al caso de uso [getAllClients].
  /// 3. El resultado del caso de uso es un [Either], que se maneja con `fold`.
  ///    - Si es un `Failure` (izquierda), emite [ClientListError] con el mensaje de error.
  ///    - Si es un éxito (derecha), emite [ClientListLoaded] con la lista de clientes.
  /// ---
  Future<void> _onFetchClients(FetchClientsEvent event, Emitter<ClientListState> emit) async {
    emit(ClientListLoading());
    final failureOrClients = await getAllClients(null); // `null` porque el use case no necesita params

    failureOrClients.fold(
      (failure) {
        const errorCode = '[ERROR-CRM002-ClientListBloc]';
        logger.e('$errorCode Fallo al obtener clientes: ${failure.message}');
        emit(ClientListError('Error: ${failure.message}'));
      },
      (clients) {
        emit(ClientListLoaded(clients));
      },
    );
  }
}