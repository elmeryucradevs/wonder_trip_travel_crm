import 'package:drift/drift.dart';

import '../../../../core/db/database.dart';
import '../../domain/entities/ticket_entity.dart';

class TicketModel extends TicketEntity {
  const TicketModel({
    required super.id,
    required super.clientId,
    required super.pnr,
    required super.totalPrice,
    required super.emissionDate,

    required super.transportType,
    required super.baseFare,
    required super.currency,

    required super.createdAt,
    required super.updatedAt,

    super.ticketNumber,
    super.flightType,
    super.passengerCategory,
    super.issuingAgent,
    super.status,
    super.taxBO,
    super.taxA7,
    super.taxQM,
    super.taxOM,
    super.otherTaxes,

    super.commission,
    super.originalTicketId,

    super.segments,
  });

  TicketsCompanion toCompanion(bool isInsert) {
    return TicketsCompanion(
      id: isInsert ? const Value.absent() : Value(id),
      clientId: Value(clientId),
      pnr: Value(pnr),
      // ... (añade todos los demás campos del ticket aquí)
    );
  }
  // Puedes añadir métodos fromJson/toJson aquí cuando conectemos a una API remota.
}