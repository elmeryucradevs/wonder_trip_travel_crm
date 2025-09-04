import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wonder_trip_travel_crm/core/config/injection_container.dart';
import 'package:wonder_trip_travel_crm/features/client_management/domain/entities/client_entity.dart';
import 'package:wonder_trip_travel_crm/features/quotes/domain/usecases/send_quote_via_whatsapp_usecase.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/flight_segment_entity.dart';
import 'package:wonder_trip_travel_crm/features/quotes/presentation/widgets/flight_segment_form.dart';

class QuoteCreationPage extends StatefulWidget {
  final ClientEntity? client;

  const QuoteCreationPage({super.key, this.client});

  @override
  State<QuoteCreationPage> createState() => _QuoteCreationPageState();
}

class _QuoteCreationPageState extends State<QuoteCreationPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _priceController = TextEditingController();
  final _includesController = TextEditingController(text: '1 equipaje de mano, 1 equipaje en bodega.');
  final _notesController = TextEditingController(text: 'Tarifa no reembolsable. Sujeta a cambios sin previo aviso.');

  final List<FlightSegmentEntity> _segments = [FlightSegmentEntity.empty()];

  final _sendQuoteUseCase = sl<SendQuoteViaWhatsAppUseCase>();

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _phoneController.text = widget.client!.phone ?? '';
    }
  }

  void _sendQuote() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_phoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, ingrese un número de teléfono.')),
        );
        return;
      }

      _sendQuoteUseCase(SendQuoteParams(
        clientPhone: _phoneController.text,
        segments: _segments,
        price: double.tryParse(_priceController.text) ?? 0.0,
        includes: _includesController.text,
        notes: _notesController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.client != null ? 'Cotizar para ${widget.client!.name}' : 'Nueva Cotización'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.client == null) ...[
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Número de Teléfono del Cliente*',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => (value == null || value.isEmpty) ? 'El teléfono es requerido' : null,
                ),
                const SizedBox(height: 24),
              ],
              Text('Tramos del Vuelo', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _segments.length,
                itemBuilder: (context, index) {
                  return FlightSegmentForm(
                    key: ValueKey(index),
                    initialData: _segments[index],
                    onChanged: (updatedSegment) {
                      setState(() {
                        _segments[index] = updatedSegment;
                      });
                    },
                    onRemove: _segments.length > 1
                        ? () => setState(() => _segments.removeAt(index))
                        : null,
                  );
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Añadir Tramo'),
                onPressed: () => setState(() => _segments.add(FlightSegmentEntity.empty())),
              ),
              const Divider(height: 32),
              Text('Detalles de la Tarifa', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Precio por Pasajero (USD)', prefixIcon: Icon(Icons.attach_money)),
                keyboardType: TextInputType.number,
                validator: (value) => (value == null || value.isEmpty) ? 'El precio es requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _includesController,
                decoration: const InputDecoration(labelText: 'Incluye', prefixIcon: Icon(Icons.check_circle_outline)),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
               TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notas Adicionales', prefixIcon: Icon(Icons.note_alt_outlined)),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _sendQuote,
        icon: const FaIcon(FontAwesomeIcons.whatsapp),
        label: const Text('Enviar Cotización'),
        heroTag: 'sendQuote',
      ),
    );
  }
}