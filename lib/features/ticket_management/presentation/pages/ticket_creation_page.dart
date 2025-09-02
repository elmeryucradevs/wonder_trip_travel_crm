// lib/features/ticket_management/presentation/pages/ticket_creation_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../client_management/domain/entities/client_entity.dart';
import '../../../ticket_import/domain/entities/parsed_ticket_data.dart';
import '../../domain/entities/flight_segment_entity.dart';
import '../../domain/entities/ticket_entity.dart';
import '../bloc/ticket_form_bloc.dart';
import '../bloc/ticket_list_bloc.dart';

class TicketCreationPage extends StatelessWidget {
  final ClientEntity client;
  final String? originalTicketNumber;
  final ParsedTicketData? parsedData;

  const TicketCreationPage({
    super.key,
    required this.client,
    this.originalTicketNumber,
    this.parsedData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TicketFormBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(originalTicketNumber == null
              ? 'Nuevo Boleto para ${client.name}'
              : 'Canje para Boleto ID: $originalTicketNumber'),
        ),
        body: BlocListener<TicketFormBloc, TicketCreationState>(
          listener: (context, state) {
            if (state is TicketCreationSuccess) {
              // Refresca la lista de boletos y vuelve
              context.read<TicketListBloc>().add(
                    FetchTicketsForClient(client.id),
                  );
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Boleto guardado'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is TicketCreationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: TicketCreationForm(
            client: client,
            originalTicketNumber: originalTicketNumber,
            parsedData: parsedData,
          ),
        ),
      ),
    );
  }
}

class TicketCreationForm extends StatefulWidget {
  final ClientEntity client;
  final String? originalTicketNumber;
  final ParsedTicketData? parsedData;
  const TicketCreationForm(
      {super.key,
      required this.client,
      this.originalTicketNumber,
      this.parsedData});

  @override
  State<TicketCreationForm> createState() => _TicketCreationFormState();
}

class _TicketCreationFormState extends State<TicketCreationForm> {
  final _formKey = GlobalKey<FormState>();

  // Usamos un Set para el SegmentedButton, que contendrá el tipo seleccionado.
  Set<String> _tripTypeSelection = {'OW'}; // Por defecto, 'OW' (One-Way)

  // Controladores para datos del BOLETO
  final _ticketNumberController = TextEditingController();
  final _pnrController = TextEditingController();
  final _agentController = TextEditingController();
  final _issueDateController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final _commissionController = TextEditingController();
  String _selectedCurrency = 'BOB';
  String _selectedStatus = 'CONFIRMADO';
  String _transportType = 'AEREO';
  String? _passengerCategory;
  bool _isUnaccompaniedMinor = false;

  bool _hasStopovers = false;
  final _stopoversController = TextEditingController();
  // --- VARIABLES DE ESTADO PARA LA VUELTA ---
  bool _hasReturnStopovers = false;
  final _returnStopoversController = TextEditingController();

  DateTime? _selectedIssueDate;

  final _outboundClassController = TextEditingController();
  final _returnClassController = TextEditingController();

  // Controladores para el SEGMENTO DE IDA
  final _outboundAirlineController = TextEditingController();
  final _outboundFlightNumController = TextEditingController();
  final _outboundOriginController = TextEditingController();
  final _outboundDestinationController = TextEditingController();
  final _outboundDepartureDateController = TextEditingController();
  final _outboundArrivalDateController = TextEditingController();
  DateTime? _selectedOutboundDepartureDate;
  DateTime? _selectedOutboundArrivalDate;

  // --- CONTROLADORES PARA EL SEGMENTO DE VUELTA ---
  final _returnAirlineController = TextEditingController();
  final _returnFlightNumController = TextEditingController();
  final _returnOriginController = TextEditingController();
  final _returnDestinationController = TextEditingController();
  final _returnDepartureDateController = TextEditingController();
  final _returnArrivalDateController = TextEditingController();
  DateTime? _selectedReturnDepartureDate;
  DateTime? _selectedReturnArrivalDate;

  @override
  void initState() {
    super.initState();
    // Pre-llenamos el formulario si hay datos parseados
    if (widget.parsedData != null) {
      _pnrController.text = widget.parsedData!.pnr ?? '';
      _totalPriceController.text = widget.parsedData!.totalPrice ?? '';
      _ticketNumberController.text = widget.parsedData!.ticketNumber ?? '';
      _selectedCurrency = widget.parsedData!.currency ?? 'BOB';
      _outboundOriginController.text = widget.parsedData!.origin ?? '';
      _outboundDestinationController.text = widget.parsedData!.destination ?? '';
      _outboundFlightNumController.text = widget.parsedData!.flightNumber ?? '';
      _outboundAirlineController.text = widget.parsedData!.airline ?? '';
      _agentController.text = widget.parsedData!.provider ?? '';

      if (widget.parsedData!.departureDate != null &&
          widget.parsedData!.departureTime != null) {
        _outboundDepartureDateController.text =
            '${widget.parsedData!.departureDate!} ${widget.parsedData!.departureTime!}';
      }

      if (widget.parsedData!.arrivalDate != null &&
          widget.parsedData!.arrivalTime != null) {
        _outboundArrivalDateController.text =
            '${widget.parsedData!.arrivalDate!} ${widget.parsedData!.arrivalTime!}';
      }

       if (widget.parsedData!.emissionDate != null ) {
        _issueDateController.text =
            '${widget.parsedData!.emissionDate!}';
      }
    }
  }

  @override
  void dispose() {
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
    bool isRoundTrip = _tripTypeSelection.first == 'RT';
    bool isAirTicket = _transportType == 'AEREO';
    bool isChild = _passengerCategory == 'CHD';

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle(context, 'Tipo de Viaje'),
            const SizedBox(height: 16),
            // --- NUEVO SELECTOR OW/RT ---
            SegmentedButton<String>(
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                    value: 'OW',
                    label: Text('Solo Ida'),
                    icon: Icon(Icons.arrow_forward)),
                ButtonSegment<String>(
                    value: 'RT',
                    label: Text('Ida y Vuelta'),
                    icon: Icon(Icons.sync_alt)),
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
                    icon: Icon(Icons.flight)),
                ButtonSegment<String>(
                    value: 'TERRESTRE',
                    label: Text('Bus'),
                    icon: Icon(Icons.directions_bus)),
              ],
              selected: {_transportType},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _transportType = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 24),
            // NUEVO: Selector de categoría de pasajero
            _buildSectionTitle(context, 'Categoría de Pasajero'),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _passengerCategory,
              items: ['ADT', 'CHD', 'SNN', 'INF']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (v) {
                setState(() {
                  _passengerCategory = v!;
                });
              },
              decoration: const InputDecoration(labelText: 'Categoría'),
              validator: (v) => v == null ? 'Requerido' : null,
            ),
            // NUEVO: Checkbox para menores que viajan solos
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
                    labelText: 'Detalles de las escalas (ej. LPB, MIA)'),
                textCapitalization: TextCapitalization.characters,
              ),
            ],
            // --- RENDERIZADO CONDICIONAL DEL FORMULARIO DE VUELTA ---
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
                      labelText: 'Detalles de las escalas (ej. LPB, MIA)'),
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
                      // Validamos que todas las fechas necesarias han sido seleccionadas
                      if (_selectedIssueDate == null ||
                          _selectedOutboundDepartureDate == null ||
                          _selectedOutboundArrivalDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Por favor, complete todas las fechas requeridas.')),
                        );
                        return;
                      }

                      // Si es ida y vuelta, validamos también las fechas de vuelta
                      if (_tripTypeSelection.first == 'RT' &&
                          (_selectedReturnDepartureDate == null ||
                              _selectedReturnArrivalDate == null)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Por favor, complete las fechas del segmento de vuelta.')),
                        );
                        return;
                      }

                      // Creamos el segmento de ida
                      final outboundSegment = FlightSegmentEntity(
                        id: 0,
                        ticketId: 0,
                        airlineCode: _outboundAirlineController.text,
                        flightClass: _outboundClassController.text,
                        flightNumber: _outboundFlightNumController.text,
                        origin: _outboundOriginController.text,
                        destination: _outboundDestinationController.text,
                        departureDate: _selectedOutboundDepartureDate!,
                        arrivalDate: _selectedOutboundArrivalDate!,
                        stopover:
                            _hasStopovers ? _stopoversController.text : null,
                      );

                      // Creamos el segmento de vuelta si es necesario
                      FlightSegmentEntity? returnSegment;
                      if (_tripTypeSelection.first == 'RT') {
                        returnSegment = FlightSegmentEntity(
                          id: 0,
                          ticketId: 0,
                          airlineCode: _returnAirlineController.text,
                          flightNumber: _returnFlightNumController.text,
                          flightClass: _returnClassController.text,
                          origin: _returnOriginController.text,
                          destination: _returnDestinationController.text,
                          departureDate: _selectedReturnDepartureDate!,
                          arrivalDate: _selectedReturnArrivalDate!,
                          stopover: _hasReturnStopovers
                              ? _returnStopoversController.text
                              : null,
                        );
                      }

                      // Despachamos el evento de CREACIÓN de boleto.
                      context.read<TicketFormBloc>().add(
                            CreateTicketSubmitted(
                              clientId: widget.client.id,
                              pnr: _pnrController.text,
                              ticketNumber: _ticketNumberController.text,
                              emissionDate: _selectedIssueDate!,
                              transportType: _transportType == 'AEREO'
                                  ? TransportType.aereo
                                  : TransportType.terrestre,
                              flightType: _tripTypeSelection.first,
                              status: _selectedStatus,
                              currency: _selectedCurrency,
                              totalPrice:
                                  double.tryParse(_totalPriceController.text) ??
                                      0.0,
                              commission:
                                  double.tryParse(_commissionController.text),
                              issuingAgent: _agentController.text,
                              passengerCategory: _passengerCategory,
                              unaccompaniedMinor: _isUnaccompaniedMinor,
                              segmentAirline: _outboundAirlineController.text,
                              segmentFlightNumber:
                                  _outboundFlightNumController.text,
                              segmentOrigin: _outboundOriginController.text,
                              segmentDestination:
                                  _outboundDestinationController.text,
                              segmentDepartureTime:
                                  _selectedOutboundDepartureDate!,
                              segmentArrivalTime:
                                  _selectedOutboundArrivalDate!,
                              stopovers: _hasStopovers
                                  ? _stopoversController.text
                                  : null,
                              returnSegment: returnSegment,
                              originalTicketNumber: widget.originalTicketNumber,
                            ),
                          );
                    }
                  },
                  child: const Text('Guardar Boleto'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.fontTitleLight,
            fontWeight: FontWeight.w600,
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
                      labelText:
                          isAirTicket ? 'Aerolínea*' : 'Empresa de Bus*'),
                  validator: (v) => v!.isEmpty ? 'Requerido' : null),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                  controller: flightNumController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                      labelText:
                          isAirTicket ? 'Nº Vuelo*' : 'Nº Asiento/Coche*'),
                  validator: (v) => v!.isEmpty ? 'Requerido' : null),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // CAMBIO: Ahora es un TextFormField
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
                      labelText:
                          isAirTicket ? 'Origen* (ej. VVI)' : 'Terminal Origen*'),
                  validator: (v) => v!.isEmpty ? 'Requerido' : null),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                  controller: destinationController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                      labelText: isAirTicket
                          ? 'Destino* (ej. CBB)'
                          : 'Terminal Destino*'),
                  validator: (v) => v!.isEmpty ? 'Requerido' : null),
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