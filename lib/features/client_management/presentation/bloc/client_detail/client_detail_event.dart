part of 'client_detail_bloc.dart';

abstract class ClientDetailEvent extends Equatable {
  const ClientDetailEvent();
  @override
  List<Object> get props => [];
}

class DeleteClientRequested extends ClientDetailEvent {
  final int clientId;
  const DeleteClientRequested(this.clientId);
  @override
  List<Object> get props => [clientId];
}

/// {@template open_whatsapp_chat_requested}
/// Evento que se dispara cuando el usuario solicita abrir un chat de WhatsApp.
/// {@endtemplate}
class OpenWhatsAppChatRequested extends ClientDetailEvent {
  /// El número de teléfono para contactar.
  final String phoneNumber;
  final ClientEntity client;


  /// {@macro open_whatsapp_chat_requested}
  const OpenWhatsAppChatRequested({required this.phoneNumber, required this.client});

  @override
  List<Object> get props => [phoneNumber, client];
}