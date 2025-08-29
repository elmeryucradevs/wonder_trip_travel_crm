part of 'ticket_detail_bloc.dart';

/// ---
/// /// Clase base abstracta para todos los eventos relacionados con la pantalla
/// /// de detalles de un boleto. Extiende [Equatable] para permitir la comparación.
/// ---
abstract class TicketDetailEvent extends Equatable {
  const TicketDetailEvent();
  @override
  List<Object> get props => [];
}

/// ---
/// /// Evento que se dispara cuando el usuario confirma la acción de eliminar un boleto.
/// ///
/// /// Contiene el [ticketId] del boleto que se va a eliminar.
/// ---
class DeleteTicketPressed extends TicketDetailEvent {
  final int ticketId;

  const DeleteTicketPressed(this.ticketId);

  @override
  List<Object> get props => [ticketId];
}