// lib/features/ticket_management/presentation/widgets/flight_timeline_widget.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/flight_segment_entity.dart';
import '../../../../core/theme/app_colors.dart';

/// ---
/// [FlightTimeline] es un widget que visualiza una lista de segmentos de vuelo
/// en un formato de línea de tiempo vertical, siguiendo un diseño estético y limpio.
///
/// Recibe una lista de [FlightSegmentEntity] y dibuja una representación
/// clara del itinerario, incluyendo los detalles de cada segmento y la duración de las escalas.
/// ---
class FlightTimeline extends StatelessWidget {
  final List<FlightSegmentEntity> segments;

  const FlightTimeline({super.key, required this.segments});

  @override
  Widget build(BuildContext context) {
    if (segments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...segments.asMap().entries.map((entry) {
          final index = entry.key;
          final segment = entry.value;
          final isLastSegment = index == segments.length - 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Muestra la tarjeta del segmento de vuelo
              _FlightSegmentCard(segment: segment),
              
              // Muestra la tarjeta de escala si no es el último segmento
              if (!isLastSegment)
                _LayoverCard(
                  currentSegment: segment,
                  nextSegment: segments[index + 1],
                ),
            ],
          );
        }).toList(),
      ],
    );
  }
}

/// Widget auxiliar para mostrar los detalles de un segmento de vuelo.
class _FlightSegmentCard extends StatelessWidget {
  final FlightSegmentEntity segment;
  const _FlightSegmentCard({required this.segment});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final flightDuration = segment.arrivalDate.difference(segment.departureDate);
    final hours = flightDuration.inHours;
    final minutes = flightDuration.inMinutes.remainder(60);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado con Aerolínea y Número de Vuelo
          Row(
            children: [
              const Icon(Icons.flight, color: AppColors.primaryLight, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${segment.airlineCode ?? ''} ${segment.flightNumber ?? ''}',
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Duración: ${hours}h ${minutes}m',
                style: textTheme.bodySmall?.copyWith(color: AppColors.fontSubtitleLight),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),

          // Detalles de la Salida
          _buildTimelineRow(
            context,
            time: DateFormat('HH:mm').format(segment.departureDate),
            airportCode: segment.origin,
            airportName: 'Aeropuerto Internacional',
          ),
          const SizedBox(height: 16),

          // Detalles de la Llegada
          _buildTimelineRow(
            context,
            time: DateFormat('HH:mm').format(segment.arrivalDate),
            airportCode: segment.destination,
            airportName: 'Aeropuerto Internacional',
          ),
          const SizedBox(height: 16),

          // Clase de cabina y Escalas
          Row(
            children: [
              // Muestra la clase de cabina
              Text(
                'Clase de cabina: ${segment.flightClass ?? 'Economy'}',
                style: textTheme.bodySmall?.copyWith(color: AppColors.fontSubtitleLight),
              ),
              if (segment.stopover != null && segment.stopover!.isNotEmpty) ...[
                const SizedBox(width: 16),
                const Icon(Icons.transfer_within_a_station, color: AppColors.accentLight, size: 20),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Escala(s) en: ${segment.stopover}',
                    style: textTheme.bodySmall?.copyWith(color: AppColors.fontSubtitleLight),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineRow(BuildContext context, {
    required String time,
    required String airportCode,
    required String airportName,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            Text(airportCode, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24)),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(airportName, style: textTheme.bodySmall?.copyWith(color: AppColors.fontSubtitleLight)),
              Text('(${airportCode})', style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors.fontSubtitleLight)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget auxiliar para mostrar el tiempo de escala entre dos vuelos.
class _LayoverCard extends StatelessWidget {
  final FlightSegmentEntity currentSegment;
  final FlightSegmentEntity nextSegment;

  const _LayoverCard({required this.currentSegment, required this.nextSegment});

  @override
  Widget build(BuildContext context) {
    final layoverDuration = nextSegment.departureDate.difference(currentSegment.arrivalDate);
    final hours = layoverDuration.inHours;
    final minutes = layoverDuration.inMinutes.remainder(60);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.accentLight.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, color: AppColors.accentLight, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Escala de ${hours}h ${minutes}m en ${currentSegment.destination}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.fontSubtitleLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}