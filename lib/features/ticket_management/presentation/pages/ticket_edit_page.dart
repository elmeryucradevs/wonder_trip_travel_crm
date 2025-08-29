// lib/features/ticket_management/presentation/pages/ticket_edit_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wonder_trip_travel_crm/core/config/injection_container.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/flight_segment_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/domain/entities/ticket_entity.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/presentation/bloc/ticket_form_bloc.dart';
import 'package:wonder_trip_travel_crm/features/ticket_management/presentation/bloc/ticket_list_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../client_management/domain/entities/client_entity.dart';

class TicketEditPage extends StatelessWidget {
  final TicketEntity ticket;
  final ClientEntity client;

  const TicketEditPage({super.key, required this.ticket, required this.client});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TicketFormBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Editar Boleto ${ticket.pnr}')),
        body: BlocListener<TicketFormBloc, TicketCreationState>(
          listener: (context, state) {
            if (state is TicketCreationSuccess) {
              context.read<TicketListBloc>().add(
                FetchTicketsForClient(client.id),
              );
              Navigator.of(context).pop(state.ticket);
            } else if (state is TicketCreationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: TicketEditForm(ticket: ticket),
        ),
      ),
    );
  }
}

class TicketEditForm extends StatefulWidget {
  final TicketEntity ticket;
  const TicketEditForm({super.key, required this.ticket});

  @override
  State<TicketEditForm> createState() => _TicketEditFormState();
}

class _TicketEditFormState extends State<TicketEditForm> {
  final _formKey = GlobalKey<FormState>();

  // 1. Declaración de todos los controladores y variables de estado
  late final TextEditingController _ticketNumberController;
  late final TextEditingController _pnrController;
  late final TextEditingController _agentController;
  late final TextEditingController _issueDateController;
  late final TextEditingController _totalPriceController;
  late final TextEditingController _commissionController;
  late String _selectedCurrency;
  late String _selectedStatus;
  late Set<String> _tripTypeSelection;
  late String? _passengerCategory;
  late bool _isUnaccompaniedMinor;

  late bool _hasStopovers;
  late final TextEditingController _stopoversController;

  late bool _hasReturnStopovers;
  late final TextEditingController _returnStopoversController;

  late String _transportType;

  // Controladores y variables de estado para el SEGMENTO DE IDA
  late final TextEditingController _outboundAirlineController;
  late final TextEditingController _outboundFlightNumController;
  late final TextEditingController _outboundOriginController;
  late final TextEditingController _outboundDestinationController;
  late final TextEditingController _outboundDepartureDateController;
  late final TextEditingController _outboundArrivalDateController;
  late final TextEditingController _outboundClassController;

  // Controladores y variables de estado para el SEGMENTO DE VUELTA
  late final TextEditingController _returnAirlineController;
  late final TextEditingController _returnFlightNumController;
  late final TextEditingController _returnOriginController;
  late final TextEditingController _returnDestinationController;
  late final TextEditingController _returnDepartureDateController;
  late final TextEditingController _returnArrivalDateController;
  late final TextEditingController _returnClassController;

  DateTime? _selectedIssueDate;
  DateTime? _selectedOutboundDepartureDate;
  DateTime? _selectedOutboundArrivalDate;
  DateTime? _selectedReturnDepartureDate;
  DateTime? _selectedReturnArrivalDate;

  @override
  void initState() {
    super.initState();
    // 2. Inicialización COMPLETA de todos los campos en initState
    final ticket = widget.ticket;
    _ticketNumberController = TextEditingController(text: ticket.ticketNumber);
    _pnrController = TextEditingController(text: ticket.pnr);
    _agentController = TextEditingController(text: ticket.issuingAgent);
    _selectedIssueDate = ticket.emissionDate;
    _issueDateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy HH:mm').format(_selectedIssueDate!),
    );
    _totalPriceController = TextEditingController(
      text: ticket.totalPrice.toString(),
    );
    _commissionController = TextEditingController(
      text: ticket.commission?.toString() ?? '',
    );
    _selectedCurrency = ticket.currency;
    _selectedStatus = ticket.status ?? 'CONFIRMADO';
    _tripTypeSelection = {ticket.flightType ?? 'OW'};
    _transportType = ticket.transportType.name.toUpperCase();
    _passengerCategory = ticket.passengerCategory;
    _isUnaccompaniedMinor = ticket.unaccompaniedMinor ?? false;

    // Inicializa segmentos de ida (asumiendo que siempre hay al menos uno)
    final segments = ticket.segments;
    _outboundAirlineController = TextEditingController();
    _outboundFlightNumController = TextEditingController();
    _outboundOriginController = TextEditingController();
    _outboundDestinationController = TextEditingController();
    _outboundDepartureDateController = TextEditingController();
    _outboundArrivalDateController = TextEditingController();
    _stopoversController = TextEditingController();
    _outboundClassController = TextEditingController();

    if (segments.isNotEmpty) {
      final outbound = segments.first;
      _outboundAirlineController.text = outbound.airlineCode ?? '';
      _outboundFlightNumController.text = outbound.flightNumber ?? '';
      _outboundOriginController.text = outbound.origin;
      _outboundDestinationController.text = outbound.destination;
      _selectedOutboundDepartureDate = outbound.departureDate;
      _outboundDepartureDateController.text = DateFormat(
        'dd/MM/yyyy HH:mm',
      ).format(outbound.departureDate);
      _selectedOutboundArrivalDate = outbound.arrivalDate;
      _outboundArrivalDateController.text = DateFormat(
        'dd/MM/yyyy HH:mm',
      ).format(outbound.arrivalDate);
      _hasStopovers =
          outbound.stopover != null && outbound.stopover!.isNotEmpty;
      _stopoversController.text = outbound.stopover ?? '';
      _outboundClassController.text = outbound.flightClass ?? '';
    } else {
      _hasStopovers = false;
    }

    // Inicializa segmentos de vuelta si existen
    _returnAirlineController = TextEditingController();
    _returnFlightNumController = TextEditingController();
    _returnOriginController = TextEditingController();
    _returnDestinationController = TextEditingController();
    _returnDepartureDateController = TextEditingController();
    _returnArrivalDateController = TextEditingController();
    _returnStopoversController = TextEditingController();
    _hasReturnStopovers =
        false; // Se inicializa como false por si el viaje cambia de RT a OW
    _returnClassController = TextEditingController();

    if (segments.length > 1) {
      final returnSeg = segments[1];
      _returnAirlineController.text = returnSeg.airlineCode ?? '';
      _returnFlightNumController.text = returnSeg.flightNumber ?? '';
      _returnOriginController.text = returnSeg.origin;
      _returnDestinationController.text = returnSeg.destination;
      _selectedReturnDepartureDate = returnSeg.departureDate;
      _returnDepartureDateController.text = DateFormat(
        'dd/MM/yyyy HH:mm',
      ).format(returnSeg.departureDate);
      _selectedReturnArrivalDate = returnSeg.arrivalDate;
      _returnArrivalDateController.text = DateFormat(
        'dd/MM/yyyy HH:mm',
      ).format(returnSeg.arrivalDate);
      _hasReturnStopovers =
          returnSeg.stopover != null && returnSeg.stopover!.isNotEmpty;
      _returnStopoversController.text = returnSeg.stopover ?? '';
      _returnClassController.text = returnSeg.flightClass ?? '';
    }
  }

  @override
  void dispose() {
    // 3. Limpieza COMPLETA de todos los controladores en dispose
    _ticketNumberController.dispose();
    _pnrController.dispose();
    _agentController.dispose();
    _issueDateController.dispose();
    _totalPriceController.dispose();
    _commissionController.dispose();
    _stopoversController.dispose();
    _outboundClassController.dispose();
    _returnClassController.dispose();

    _outboundAirlineController.dispose();
    _outboundFlightNumController.dispose();
    _outboundOriginController.dispose();
    _outboundDestinationController.dispose();
    _outboundDepartureDateController.dispose();
    _outboundArrivalDateController.dispose();

    _returnAirlineController.dispose();
    _returnFlightNumController.dispose();
    _returnOriginController.dispose();
    _returnDestinationController.dispose();
    _returnDepartureDateController.dispose();
    _returnArrivalDateController.dispose();
    _returnStopoversController.dispose();
    super.dispose();
  }

  /// Función auxiliar para el selector de fecha y hora.
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
        if (!mounted) return;
        onDateSelected(fullDateTime);
        controller.text = DateFormat('dd/MM/yyyy HH:mm').format(fullDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRoundTrip = _tripTypeSelection.first == 'RT';
    final isAirTicket = _transportType == 'AEREO';
    final isChild = _passengerCategory == 'CHD';

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle(context, 'Tipo de Viaje'),
            const SizedBox(height: 16),
            SegmentedButton<String>(
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: 'OW',
                  label: Text('Solo Ida'),
                  icon: Icon(Icons.arrow_forward),
                ),
                ButtonSegment<String>(
                  value: 'RT',
                  label: Text('Ida y Vuelta'),
                  icon: Icon(Icons.sync_alt),
                ),
              ],
              selected: _tripTypeSelection,
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _tripTypeSelection = newSelection;
                });
              },
            ),
            _buildSectionTitle(context, 'Información General del Boleto'),
            const SizedBox(height: 16),
            TextFormField(
              controller: _pnrController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'PNR o Código de Reserva*',
              ),
              validator: (v) => v!.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ticketNumberController,
              decoration: const InputDecoration(labelText: 'Número de Boleto'),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _agentController,
              decoration: const InputDecoration(labelText: 'Proveedor*'),
              validator: (v) => v!.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _issueDateController,
              decoration: const InputDecoration(
                labelText: 'Fecha de Emisión*',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDateTime(
                context,
                _issueDateController,
                (date) => _selectedIssueDate = date,
              ),
              validator: (v) => v!.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Tipo de Transporte'),
            const SizedBox(height: 16),
            SegmentedButton<String>(
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: 'AEREO',
                  label: Text('Aéreo'),
                  icon: Icon(Icons.flight),
                ),
                ButtonSegment<String>(
                  value: 'TERRESTRE',
                  label: Text('Bus'),
                  icon: Icon(Icons.directions_bus),
                ),
              ],
              selected: {_transportType},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _transportType = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Categoría de Pasajero'),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _passengerCategory,
              items: ['ADT', 'CHD', 'SNN', 'INF']
                  .map(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                setState(() {
                  _passengerCategory = v!;
                });
              },
              decoration: const InputDecoration(labelText: 'Categoría'),
              validator: (v) => v == null ? 'Requerido' : null,
            ),
            if (isChild)
              CheckboxListTile(
                title: const Text("Viaja solo (Menor no acompañado)"),
                value: _isUnaccompaniedMinor,
                onChanged: (newValue) {
                  setState(() {
                    _isUnaccompaniedMinor = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Segmento de Vuelo (Ida)'),
            const SizedBox(height: 16),
            _buildFlightSegmentForm(
              airlineController: _outboundAirlineController,
              flightNumController: _outboundFlightNumController,
              classController: _outboundClassController,
              originController: _outboundOriginController,
              destinationController: _outboundDestinationController,
              departureDateController: _outboundDepartureDateController,
              arrivalDateController: _outboundArrivalDateController,
              onDepartureDateSelected: (date) =>
                  _selectedOutboundDepartureDate = date,
              onArrivalDateSelected: (date) =>
                  _selectedOutboundArrivalDate = date,
              isAirTicket: isAirTicket,
            ),
            CheckboxListTile(
              title: const Text("Este segmento tiene escalas"),
              value: _hasStopovers,
              onChanged: (newValue) {
                setState(() {
                  _hasStopovers = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            if (_hasStopovers) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _stopoversController,
                decoration: const InputDecoration(
                  labelText: 'Detalles de las escalas (ej. LPB, MIA)',
                ),
                textCapitalization: TextCapitalization.characters,
              ),
            ],
            if (isRoundTrip) ...[
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Segmento de Vuelo (Vuelta)'),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text("Este segmento tiene escalas"),
                value: _hasReturnStopovers,
                onChanged: (newValue) {
                  setState(() {
                    _hasReturnStopovers = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              if (_hasReturnStopovers) ...[
                const SizedBox(height: 8),
                TextFormField(
                  controller: _returnStopoversController,
                  decoration: const InputDecoration(
                    labelText: 'Detalles de las escalas (ej. LPB, MIA)',
                  ),
                  textCapitalization: TextCapitalization.characters,
                ),
              ],
              _buildFlightSegmentForm(
                airlineController: _returnAirlineController,
                flightNumController: _returnFlightNumController,
                classController: _returnClassController,
                originController: _returnOriginController,
                destinationController: _returnDestinationController,
                departureDateController: _returnDepartureDateController,
                arrivalDateController: _returnArrivalDateController,
                onDepartureDateSelected: (date) =>
                    _selectedReturnDepartureDate = date,
                onArrivalDateSelected: (date) =>
                    _selectedReturnArrivalDate = date,
                isAirTicket: isAirTicket,
              ),
            ],

            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Detalles de Tarifa'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _totalPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Precio Total*',
                      prefixText: '\$ ',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) => v!.isEmpty ? 'Requerido' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _commissionController,
                    decoration: const InputDecoration(
                      labelText: 'Comisión',
                      prefixText: '\$ ',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCurrency,
                    items: ['USD', 'BOB']
                        .map(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedCurrency = v!),
                    decoration: const InputDecoration(labelText: 'Divisa'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    items: ['CONFIRMADO', 'CANCELADO', 'REEMBOLSADO']
                        .map(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedStatus = v!),
                    decoration: const InputDecoration(labelText: 'Estado'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            BlocBuilder<TicketFormBloc, TicketCreationState>(
              builder: (context, state) {
                if (state is TicketCreationLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedIssueDate == null ||
                          _selectedOutboundDepartureDate == null ||
                          _selectedOutboundArrivalDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, complete todas las fechas requeridas.',
                            ),
                          ),
                        );
                        return;
                      }

                      if (isRoundTrip &&
                          (_selectedReturnDepartureDate == null ||
                              _selectedReturnArrivalDate == null)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, complete las fechas del segmento de vuelta.',
                            ),
                          ),
                        );
                        return;
                      }

                      final List<FlightSegmentEntity> updatedSegments = [];
                      updatedSegments.add(
                        FlightSegmentEntity(
                          id: widget.ticket.segments.isNotEmpty
                              ? widget.ticket.segments.first.id
                              : 0,
                          ticketId: widget.ticket.id,
                          airlineCode: _outboundAirlineController.text,
                          flightNumber: _outboundFlightNumController.text,
                          origin: _outboundOriginController.text,
                          destination: _outboundDestinationController.text,
                          departureDate: _selectedOutboundDepartureDate!,
                          arrivalDate: _selectedOutboundArrivalDate!,
                          flightClass: _outboundClassController.text.isNotEmpty
                              ? _outboundClassController.text
                              : null,
                          stopover: _hasStopovers
                              ? _stopoversController.text
                              : null,
                        ),
                      );

                      if (isRoundTrip) {
                        updatedSegments.add(
                          FlightSegmentEntity(
                            id: widget.ticket.segments.length > 1
                                ? widget.ticket.segments[1].id
                                : 0,
                            ticketId: widget.ticket.id,
                            airlineCode: _returnAirlineController.text,
                            flightNumber: _returnFlightNumController.text,
                            origin: _returnOriginController.text,
                            destination: _returnDestinationController.text,
                            departureDate: _selectedReturnDepartureDate!,
                            arrivalDate: _selectedReturnArrivalDate!,
                            flightClass: _returnClassController.text.isNotEmpty
                                ? _returnClassController.text
                                : null,
                            stopover: _hasReturnStopovers
                                ? _returnStopoversController.text
                                : null,
                          ),
                        );
                      }

                      final updatedTicket = widget.ticket.copyWith(
                        pnr: _pnrController.text,
                        issuingAgent: _agentController.text,
                        emissionDate: _selectedIssueDate,
                        ticketNumber: _ticketNumberController.text,
                        status: _selectedStatus,
                        currency: _selectedCurrency,
                        flightType: _tripTypeSelection.first,
                        passengerCategory: _passengerCategory,
                        unaccompaniedMinor: _isUnaccompaniedMinor,
                        totalPrice: double.tryParse(_totalPriceController.text),
                        commission: double.tryParse(_commissionController.text),
                        segments: updatedSegments,
                      );

                      context.read<TicketFormBloc>().add(
                        UpdateTicketSubmitted(updatedTicket),
                      );
                    }
                  },
                  child: const Text('Guardar Cambios'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.fontTitleLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFlightSegmentForm({
    required TextEditingController airlineController,
    required TextEditingController flightNumController,
    required TextEditingController classController,
    required TextEditingController originController,
    required TextEditingController destinationController,
    required TextEditingController departureDateController,
    required TextEditingController arrivalDateController,
    required Function(DateTime) onDepartureDateSelected,
    required Function(DateTime) onArrivalDateSelected,
    required bool isAirTicket,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: airlineController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: isAirTicket ? 'Aerolínea*' : 'Empresa de Bus*',
                ),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: flightNumController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: isAirTicket ? 'Nº Vuelo*' : 'Nº Asiento/Coche*',
                ),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: classController,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(labelText: 'Clase'),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: originController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: isAirTicket
                      ? 'Origen* (ej. VVI)'
                      : 'Terminal Origen*',
                ),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: destinationController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: isAirTicket
                      ? 'Destino* (ej. CBB)'
                      : 'Terminal Destino*',
                ),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: departureDateController,
          decoration: const InputDecoration(
            labelText: 'Salida*',
            suffixIcon: Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () => _selectDateTime(
            context,
            departureDateController,
            onDepartureDateSelected,
          ),
          validator: (v) => v!.isEmpty ? 'Requerido' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: arrivalDateController,
          decoration: const InputDecoration(
            labelText: 'Llegada*',
            suffixIcon: Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () => _selectDateTime(
            context,
            arrivalDateController,
            onArrivalDateSelected,
          ),
          validator: (v) => v!.isEmpty ? 'Requerido' : null,
        ),
      ],
    );
  }
}
