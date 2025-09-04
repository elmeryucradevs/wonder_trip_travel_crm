// lib/features/quotes/presentation/widgets/flight_segment_form.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/flight_segment_entity.dart';

class FlightSegmentForm extends StatefulWidget {
  final FlightSegmentEntity initialData;
  final ValueChanged<FlightSegmentEntity> onChanged;
  final VoidCallback? onRemove;

  const FlightSegmentForm({
    super.key,
    required this.initialData,
    required this.onChanged,
    this.onRemove,
  });

  @override
  _FlightSegmentFormState createState() => _FlightSegmentFormState();
}

class _FlightSegmentFormState extends State<FlightSegmentForm> {
  late FlightSegmentEntity _segmentData;
  final _departureDateController = TextEditingController();
  final _arrivalDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _segmentData = widget.initialData;
    _departureDateController.text =
        DateFormat('dd/MM/yyyy HH:mm').format(_segmentData.departureDate);
    _arrivalDateController.text =
        DateFormat('dd/MM/yyyy HH:mm').format(_segmentData.arrivalDate);
  }

  @override
  void dispose() {
    _departureDateController.dispose();
    _arrivalDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(
    BuildContext context,
    TextEditingController controller,
    Function(DateTime) onDateSelected,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onDateSelected(fullDateTime);
        controller.text = DateFormat('dd/MM/yyyy HH:mm').format(fullDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tramo', style: Theme.of(context).textTheme.titleMedium),
                if (widget.onRemove != null)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: widget.onRemove,
                  ),
              ],
            ),
            TextFormField(
              initialValue: _segmentData.origin,
              decoration: const InputDecoration(labelText: 'Origen (e.g., VVI)'),
              onChanged: (value) {
                _segmentData = _segmentData.copyWith(origin: value);
                widget.onChanged(_segmentData);
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: _segmentData.destination,
              decoration:
                  const InputDecoration(labelText: 'Destino (e.g., CBB)'),
              onChanged: (value) {
                _segmentData = _segmentData.copyWith(destination: value);
                widget.onChanged(_segmentData);
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: _segmentData.airlineCode,
              decoration: const InputDecoration(labelText: 'Aerolínea'),
              onChanged: (value) {
                _segmentData = _segmentData.copyWith(airlineCode: value);
                widget.onChanged(_segmentData);
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: _segmentData.flightNumber,
              decoration: const InputDecoration(labelText: 'Número de Vuelo'),
              onChanged: (value) {
                _segmentData = _segmentData.copyWith(flightNumber: value);
                widget.onChanged(_segmentData);
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _departureDateController,
              decoration: const InputDecoration(
                labelText: 'Salida',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDateTime(
                context,
                _departureDateController,
                (date) {
                  _segmentData = _segmentData.copyWith(departureDate: date);
                  widget.onChanged(_segmentData);
                },
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _arrivalDateController,
              decoration: const InputDecoration(
                labelText: 'Llegada',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDateTime(
                context,
                _arrivalDateController,
                (date) {
                  _segmentData = _segmentData.copyWith(arrivalDate: date);
                  widget.onChanged(_segmentData);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}