import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../client_management/domain/entities/client_entity.dart';
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

  // Controladores para datos del BOLETO
  final _pnrController = TextEditingController();
  final _agentController = TextEditingController();
  final _issueDateController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final _commissionController = TextEditingController();
  String _selectedCurrency = 'USD';
  String _selectedStatus = 'CONFIRMADO';

  // Controladores para el SEGMENTO DE VUELO
  final _airlineController = TextEditingController();
  final _flightNumController = TextEditingController();
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _departureDateController = TextEditingController();
  final _arrivalDateController = TextEditingController();

  DateTime? _selectedIssueDate;
  DateTime? _selectedDepartureDate;
  DateTime? _selectedArrivalDate;

  @override
  void dispose() {
    _pnrController.dispose();
    _agentController.dispose();
    _issueDateController.dispose();
    _totalPriceController.dispose();
    _commissionController.dispose();
    _airlineController.dispose();
    _flightNumController.dispose();
    _originController.dispose();
    _destinationController.dispose();
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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle(context, 'Información del Boleto'),
            const SizedBox(height: 16),
            TextFormField(
              controller: _pnrController,
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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _airlineController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(labelText: 'Aerolínea*'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _flightNumController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(labelText: 'Nº Vuelo*'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _originController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'Origen* (ej. VVI)',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _destinationController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'Destino* (ej. CBB)',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _departureDateController,
              decoration: const InputDecoration(
                labelText: 'Salida*',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDateTime(
                context,
                _departureDateController,
                (date) => _selectedDepartureDate = date,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _arrivalDateController,
              decoration: const InputDecoration(
                labelText: 'Llegada*',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDateTime(
                context,
                _arrivalDateController,
                (date) => _selectedArrivalDate = date,
              ),
            ),

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
                      context.read<TicketCreationBloc>().add(
                        CreateTicketSubmitted(
                          clientId: widget.client.id,
                          pnr: _pnrController.text,
                          issuingAgent: _agentController.text,
                          emissionDate: _selectedIssueDate!,
                          status: _selectedStatus,
                          currency: _selectedCurrency,
                          totalPrice:
                              double.tryParse(_totalPriceController.text) ??
                              0.0,
                          commission: double.tryParse(
                            _commissionController.text,
                          ),
                          baseFare: 0.0, // TODO: Calcular esto
                          segmentAirline: _airlineController.text,
                          segmentFlightNumber: _flightNumController.text,
                          segmentOrigin: _originController.text,
                          segmentDestination: _destinationController.text,
                          segmentDepartureTime: _selectedDepartureDate!,
                          segmentArrivalTime: _selectedArrivalDate!,
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
}
