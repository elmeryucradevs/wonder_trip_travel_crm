// lib/features/client_management/domain/usecases/open_whatsapp_chat_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// [ERROR-CRM015-WHATSAPP]
const String WHATSAPP_LAUNCH_ERROR_CODE = '[ERROR-CRM015-WHATSAPP]';

/// {@template open_whatsapp_chat_usecase}
/// Caso de uso para abrir una conversación de WhatsApp con un cliente,
/// con la capacidad de incluir un mensaje predefinido.
/// {@endtemplate}
class OpenWhatsAppChatUseCase implements UseCase<void, OpenWhatsAppChatParams> {

  @override
  Future<Either<Failure, void>> call(OpenWhatsAppChatParams params) async {
    // Asegúrate de que el número de teléfono esté en formato internacional (ej: 59172345678 para Bolivia)
    final phoneNumber = params.phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Construcción de la URI con o sin mensaje
    final Uri uri;
    if (params.message != null && params.message!.isNotEmpty) {
      final encodedMessage = Uri.encodeComponent(params.message!);
      // CAMBIO: Usamos el endpoint api.whatsapp.com que es más robusto para la codificación
      uri = Uri.parse('https://api.whatsapp.com/send?phone=$phoneNumber&text=$encodedMessage');
    } else {
      // CAMBIO: Usamos el endpoint api.whatsapp.com también aquí
      uri = Uri.parse('https://api.whatsapp.com/send?phone=$phoneNumber');
    }

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return const Right(null);
      } else {
        print('$WHATSAPP_LAUNCH_ERROR_CODE No se puede abrir el enlace de WhatsApp. ¿Está instalado?');
        return Left(ExternalAppFailure(
          message: 'No se pudo abrir WhatsApp. Verifique que esté instalado.',
          code: WHATSAPP_LAUNCH_ERROR_CODE,
        ));
      }
    } catch (e) {
      print('$WHATSAPP_LAUNCH_ERROR_CODE Error al intentar abrir WhatsApp: $e');
      return Left(ExternalAppFailure(
        message: 'Ocurrió un error inesperado al abrir WhatsApp.',
        code: WHATSAPP_LAUNCH_ERROR_CODE,
      ));
    }
  }
}

/// Parámetros para el [OpenWhatsAppChatUseCase].
class OpenWhatsAppChatParams extends Equatable {
  /// El número de teléfono del cliente.
  final String phoneNumber;
  /// [NUEVO] El mensaje opcional a pre-rellenar en el chat.
  final String? message;

  const OpenWhatsAppChatParams({required this.phoneNumber, this.message});

  @override
  List<Object?> get props => [phoneNumber, message];
}