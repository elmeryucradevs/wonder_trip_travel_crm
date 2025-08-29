part of 'ticket_detail_bloc.dart';

/// ---
/// /// Clase base abstracta para todos los estados de la pantalla de detalles
/// /// de un boleto. Extiende [Equatable] para que el [BlocBuilder] o
/// /// [BlocListener] pueda reaccionar eficientemente a los cambios.
/// ---
abstract class TicketDetailState extends Equatable {
  const TicketDetailState();
  @override
  List<Object> get props => [];
}

/// ---
/// /// El estado inicial, antes de que se realice cualquier acción.
/// ---
class TicketDetailInitial extends TicketDetailState {}

/// ---
/// /// Estado que indica que una operación (como la eliminación) está en progreso.
/// /// La UI podría mostrar un indicador de carga.
/// ---
class TicketDetailLoading extends TicketDetailState {}

/// ---
/// /// Estado que indica que la eliminación del boleto se completó con éxito.
/// /// El [BlocListener] usará este estado para navegar hacia atrás y mostrar un SnackBar.
/// ---
class TicketDetailDeleteSuccess extends TicketDetailState {}

/// ---
/// /// Estado que indica que ocurrió un error durante una operación.
/// ///
/// /// Contiene un [message] para ser mostrado al usuario.
/// ---
class TicketDetailFailure extends TicketDetailState {
  final String message;

  const TicketDetailFailure(this.message);

  @override
  List<Object> get props => [message];
}