import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/client_entity.dart';
import '../bloc/client_creation/client_creation_bloc.dart'; // Reutilizaremos este BLoC
import '../bloc/client_list_bloc.dart';

/// ---
/// [ClientEditPage] es la pantalla que contiene el formulario para editar
/// un cliente existente.
///
/// Recibe un [ClientEntity] para pre-rellenar los campos del formulario.
/// ---
class ClientEditPage extends StatelessWidget {
  final ClientEntity client;

  const ClientEditPage({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    // Proveemos el ClientCreationBloc que también manejará la lógica de actualización.
    return BlocProvider(
      create: (_) => sl<ClientCreationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Cliente'),
        ),
        body: BlocListener<ClientCreationBloc, ClientCreationState>(
          listener: (context, state) {
            if (state is ClientCreationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliente actualizado con éxito'),
                  backgroundColor: Colors.green,
                ),
              );
              // Refresca la lista y vuelve a la página anterior.
              context.read<ClientListBloc>().add(FetchClientsEvent());
              Navigator.of(context).pop();
            } else if (state is ClientCreationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          // Pasamos el cliente al formulario.
          child: ClientEditForm(client: client),
        ),
      ),
    );
  }
}

/// ---
/// [ClientEditForm] es el formulario pre-rellenado para la edición.
/// ---
class ClientEditForm extends StatefulWidget {
  final ClientEntity client;
  const ClientEditForm({super.key, required this.client});

  @override
  State<ClientEditForm> createState() => _ClientEditFormState();
}

class _ClientEditFormState extends State<ClientEditForm> {
  final _formKey = GlobalKey<FormState>();
  // --- INICIALIZAMOS LOS CONTROLADORES CON LOS DATOS DEL CLIENTE ---
  late final TextEditingController _nameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _docNumberController;
  late final TextEditingController _docTypeController;
  late final TextEditingController _travelerNumController;
  late final TextEditingController _billingNameController;
  late final TextEditingController _billingDocController;
  late final TextEditingController _billingAddrController;
  late final TextEditingController _birthDateController;
  DateTime? _selectedBirthDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.client.name);
    _lastNameController = TextEditingController(text: widget.client.lastName);
    _emailController = TextEditingController(text: widget.client.email);
    _phoneController = TextEditingController(text: widget.client.phone);
    _docNumberController = TextEditingController(text: widget.client.documentNumber);
    _docTypeController = TextEditingController(text: widget.client.documentType);
    _travelerNumController = TextEditingController(text: widget.client.travelerNumber);
    _billingNameController = TextEditingController(text: widget.client.billingName);
    _billingDocController = TextEditingController(text: widget.client.billingDocument);
    _billingAddrController = TextEditingController(text: widget.client.billingAddress);
    _selectedBirthDate = widget.client.birthDate;
    _birthDateController = TextEditingController(
      text: _selectedBirthDate != null ? DateFormat('dd/MM/yyyy').format(_selectedBirthDate!) : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _docNumberController.dispose();
    _docTypeController.dispose();
    _travelerNumController.dispose();
    _billingNameController.dispose();
    _billingDocController.dispose();
    _billingAddrController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // El build del formulario es casi idéntico al de creación
    // La única diferencia será la lógica del botón "Guardar Cambios"
    // (Por ahora, la dejaremos igual, la ajustaremos en el BLoC)
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ... (Todos los TextFormField son idénticos al del formulario de creación)
            TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nombres*')),
            const SizedBox(height: 16),
            TextFormField(controller: _lastNameController, decoration: const InputDecoration(labelText: 'Apellidos*')),
            const SizedBox(height: 16),
            TextFormField(
              controller: _birthDateController,
              decoration: const InputDecoration(
                labelText: 'Fecha de Nacimiento',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedBirthDate ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedBirthDate = pickedDate;
                    _birthDateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(controller: _docNumberController, decoration: const InputDecoration(labelText: 'Nº Documento*')),
            const SizedBox(height: 16),
            TextFormField(controller: _docTypeController, decoration: const InputDecoration(labelText: 'Tipo Documento')),
            const SizedBox(height: 16),
            TextFormField(controller: _travelerNumController, decoration: const InputDecoration(labelText: 'Nº Viajero Frecuente')),
            const SizedBox(height: 16),
            TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'Correo Electrónico')),
            const SizedBox(height: 16),
            TextFormField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Teléfono')),
            _buildSectionTitle(context, 'Datos de Facturación'),
            const SizedBox(height: 16),
            TextFormField(
              controller: _billingNameController,
              decoration: const InputDecoration(labelText: 'Nombre o Razón Social'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _billingDocController,
              decoration: const InputDecoration(labelText: 'NIT o Documento'),
            ),
             const SizedBox(height: 16),
            TextFormField(
              controller: _billingAddrController,
              decoration: const InputDecoration(labelText: 'Dirección'),
            ),
            const SizedBox(height: 32),
            BlocBuilder<ClientCreationBloc, ClientCreationState>(
              builder: (context, state) {
                if (state is ClientCreationLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // 1. Creamos una nueva instancia de ClientEntity con los datos actualizados.
                      //    Es crucial mantener el ID original del widget.
                      final updatedClient = widget.client.copyWith(
                        name: _nameController.text,
                        lastName: _lastNameController.text,
                        birthDate: _selectedBirthDate,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        documentNumber: _docNumberController.text,
                        documentType: _docTypeController.text,
                        travelerNumber: _travelerNumController.text,
                      );
                      
                      // 2. Despachamos el nuevo evento al BLoC.
                      context.read<ClientCreationBloc>().add(UpdateClientEvent(updatedClient));
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
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.fontTitleLight,
            fontWeight: FontWeight.w600,
          ),
    );
  }
  
}