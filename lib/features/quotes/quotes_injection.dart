// lib/features/quotes/quotes_injection.dart

import 'package:wonder_trip_travel_crm/core/config/injection_container.dart';
import 'package:wonder_trip_travel_crm/features/quotes/domain/usecases/send_quote_via_whatsapp_usecase.dart';

void initQuotes() {
  // Use cases
  sl.registerLazySingleton(() => SendQuoteViaWhatsAppUseCase(sl()));
}