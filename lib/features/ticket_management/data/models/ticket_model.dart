// lib/features/ticket_management/data/models/ticket_model.dart

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
    required super.currency,

    required super.createdAt,
    required super.updatedAt,

    super.ticketNumber,
    super.flightType,
    super.passengerCategory,
    super.unaccompaniedMinor,
    super.issuingAgent,
    super.status,

    super.commission,
    super.originalTicketId,

    super.segments,
  });

  TicketsCompanion toCompanion(bool isInsert) {
    return TicketsCompanion(
      id: isInsert ? const Value.absent() : Value(id),
      clientId: Value(clientId),
      pnr: Value(pnr),
      emissionDate: Value(emissionDate),
      transportType: Value(transportType.name),
      ticketNumber: Value(ticketNumber),
      flightType: Value(flightType),
      passengerCategory: Value(passengerCategory),
      unaccompaniedMinor: Value(unaccompaniedMinor),
      issuingAgent: Value(issuingAgent),
      status: Value(status),
      currency: Value(currency),
      totalPrice: Value(totalPrice),
      commission: Value(commission),
      originalTicketId: Value(originalTicketId),
      createdAt: isInsert ? const Value.absent() : Value(createdAt),
      updatedAt: Value(DateTime.now()), // Siempre actualizamos esta fecha
    );
  }
  // Puedes añadir métodos fromJson/toJson aquí cuando conectemos a una API remota.
}