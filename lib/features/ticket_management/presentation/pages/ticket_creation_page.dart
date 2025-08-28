import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../client_management/domain/entities/client_entity.dart';
import '../../domain/entities/flight_segment_entity.dart';
import '../bloc/ticket_creation_bloc.dart';
import '../bloc/ticket_list_bloc.dart';

class TicketCreationPage extends StatelessWidget {
  final ClientEntity client;
  const TicketCreationPage({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TicketCreationBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Nuevo Boleto para ${client.name}')),
        body: BlocListener<TicketCreationBloc, TicketCreationState>(
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
          child: TicketCreationForm(client: client),
        ),
      ),
    );
  }
}

class TicketCreationForm extends StatefulWidget {
  final ClientEntity client;
  const TicketCreationForm({super.key, required this.client});

  @override
  State<TicketCreationForm> createState() => _TicketCreationFormState();
}

class _TicketCreationFormState extends State<TicketCreationForm> {
  final _formKey = GlobalKey<FormState>();

  // Usamos un Set para el SegmentedButton, que contendrá el tipo seleccionado.
  Set<String> _tripTypeSelection = {'OW'}; // Por defecto, 'OW' (One-Way)

  // Controladores para datos del BOLETO
  final _pnrController = TextEditingController();
  final _agentController = TextEditingController();
  final _issueDateController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final _commissionController = TextEditingController();
  String _selectedCurrency = 'USD';
  String _selectedStatus = 'CONFIRMADO';
  DateTime? _selectedIssueDate;

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
  void dispose() {
    _pnrController.dispose();
    _agentController.dispose();
    _issueDateController.dispose();
    _totalPriceController.dispose();
    _commissionController.dispose();

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
                ButtonSegment<String>(value: 'OW', label: Text('Solo Ida'), icon: Icon(Icons.arrow_forward)),
                ButtonSegment<String>(value: 'RT', label: Text('Ida y Vuelta'), icon: Icon(Icons.sync_alt)),
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
            _buildSectionTitle(context, 'Segmento de Vuelo (Ida)'),
            const SizedBox(height: 16),
            _buildFlightSegmentForm(
              airlineController: _outboundAirlineController,
              flightNumController: _outboundFlightNumController,
              originController: _outboundOriginController,
              destinationController: _outboundDestinationController,
              departureDateController: _outboundDepartureDateController,
              arrivalDateController: _outboundArrivalDateController,
              onDepartureDateSelected: (date) => _selectedOutboundDepartureDate = date,
              onArrivalDateSelected: (date) => _selectedOutboundArrivalDate = date,
            ),

            // --- RENDERIZADO CONDICIONAL DEL FORMULARIO DE VUELTA ---
            if (isRoundTrip) ...[
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Segmento de Vuelo (Vuelta)'),
              const SizedBox(height: 16),
              _buildFlightSegmentForm(
                airlineController: _returnAirlineController,
                flightNumController: _returnFlightNumController,
                originController: _returnOriginController,
                destinationController: _returnDestinationController,
                departureDateController: _returnDepartureDateController,
                arrivalDateController: _returnArrivalDateController,
                onDepartureDateSelected: (date) => _selectedReturnDepartureDate = date,
                onArrivalDateSelected: (date) => _selectedReturnArrivalDate = date,
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
            BlocBuilder<TicketCreationBloc, TicketCreationState>(
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
                          const SnackBar(content: Text('Por favor, complete todas las fechas requeridas.')),
                        );
                        return;
                      }
                      
                      // Si es ida y vuelta, validamos también las fechas de vuelta
                      if (_tripTypeSelection.first == 'RT' &&
                          (_selectedReturnDepartureDate == null ||
                          _selectedReturnArrivalDate == null)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Por favor, complete las fechas del segmento de vuelta.')),
                        );
                        return;
                      }

                      // Creamos el segmento de vuelta si es necesario
                      FlightSegmentEntity? returnSegment;
                      if (_tripTypeSelection.first == 'RT') {
                        returnSegment = FlightSegmentEntity(
                          id: 0, ticketId: 0,
                          airlineCode: _returnAirlineController.text,
                          flightNumber: _returnFlightNumController.text,
                          origin: _returnOriginController.text,
                          destination: _returnDestinationController.text,
                          departureDate: _selectedReturnDepartureDate!,
                          arrivalDate: _selectedReturnArrivalDate!,
                        );
                      }

                      // Despachamos el evento al BLoC
                      context.read<TicketCreationBloc>().add(
                            CreateTicketSubmitted(
                              clientId: widget.client.id,
                              pnr: _pnrController.text,
                              issuingAgent: _agentController.text,
                              emissionDate: _selectedIssueDate!,
                              status: _selectedStatus,
                              currency: _selectedCurrency,
                              flightType: _tripTypeSelection.first,
                              totalPrice: double.tryParse(_totalPriceController.text) ?? 0.0,
                              commission: double.tryParse(_commissionController.text),
                              baseFare: 0.0, // TODO: Calcular esto
                              segmentAirline: _outboundAirlineController.text,
                              segmentFlightNumber: _outboundFlightNumController.text,
                              segmentOrigin: _outboundOriginController.text,
                              segmentDestination: _outboundDestinationController.text,
                              segmentDepartureTime: _selectedOutboundDepartureDate!,
                              segmentArrivalTime: _selectedOutboundArrivalDate!,
                              returnSegment: returnSegment,
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
    required TextEditingController originController,
    required TextEditingController destinationController,
    required TextEditingController departureDateController,
    required TextEditingController arrivalDateController,
    required Function(DateTime) onDepartureDateSelected,
    required Function(DateTime) onArrivalDateSelected,
  }) {
    return Column(
      children: [
        Row(children: [ Expanded(child: TextFormField(controller: airlineController, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Aerolínea*'), validator: (v) => v!.isEmpty ? 'Requerido' : null)), const SizedBox(width: 16), Expanded(child: TextFormField(controller: flightNumController, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Nº Vuelo*'), validator: (v) => v!.isEmpty ? 'Requerido' : null))]),
        const SizedBox(height: 16),
        Row(children: [ Expanded(child: TextFormField(controller: originController, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Origen* (ej. VVI)'), validator: (v) => v!.isEmpty ? 'Requerido' : null)), const SizedBox(width: 16), Expanded(child: TextFormField(controller: destinationController, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Destino* (ej. CBB)'), validator: (v) => v!.isEmpty ? 'Requerido' : null))]),
        const SizedBox(height: 16),
        TextFormField(controller: departureDateController, decoration: const InputDecoration(labelText: 'Salida*', suffixIcon: Icon(Icons.calendar_today)), readOnly: true, onTap: () => _selectDateTime(context, departureDateController, onDepartureDateSelected), validator: (v) => v!.isEmpty ? 'Requerido' : null),
        const SizedBox(height: 16),
        TextFormField(controller: arrivalDateController, decoration: const InputDecoration(labelText: 'Llegada*', suffixIcon: Icon(Icons.calendar_today)), readOnly: true, onTap: () => _selectDateTime(context, arrivalDateController, onArrivalDateSelected), validator: (v) => v!.isEmpty ? 'Requerido' : null),
      ],
    );
  }
}
