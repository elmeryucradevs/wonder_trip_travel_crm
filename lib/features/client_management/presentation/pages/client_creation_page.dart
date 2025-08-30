import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/client_creation/client_creation_bloc.dart';
import '../bloc/client_list_bloc.dart';

/// ---
/// [ClientCreationPage] es la pantalla que contiene el formulario para
/// crear un nuevo cliente.
///
/// Utiliza un [GlobalKey<FormState>] para gestionar la validación y el estado
/// del formulario.
/// ---
class ClientCreationPage extends StatelessWidget {
  const ClientCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Envolvemos la página con el BlocProvider para el nuevo BLoC.
    return BlocProvider(
      create: (_) => sl<ClientCreationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar Nuevo Cliente'),
        ),
        body: BlocListener<ClientCreationBloc, ClientCreationState>(
          // BlocListener para efectos secundarios como navegación y SnackBars.
          listener: (context, state) {
            if (state is ClientCreationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliente guardado con éxito'),
                  backgroundColor: Colors.green,
                ),
              );
              // Refresca la lista de clientes en la página anterior.
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
          child: const ClientCreationForm(),
        ),
      ),
    );
  }
}

/// ---
/// [ClientCreationForm] es el widget que contiene la lógica y los campos
/// del formulario.
///
/// Es un [StatefulWidget] para poder gestionar los controladores de texto.
/// ---
class ClientCreationForm extends StatefulWidget {
  const ClientCreationForm({super.key});

  @override
  State<ClientCreationForm> createState() => _ClientCreationFormState();
}

class _ClientCreationFormState extends State<ClientCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  DateTime? _selectedBirthDate;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _docNumberController = TextEditingController();
  final _docTypeController = TextEditingController();
  final _travelerNumController = TextEditingController();
  final _billingNameController = TextEditingController();
  final _billingDocController = TextEditingController();
  final _billingAddrController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _docNumberController.dispose();
    _docTypeController.dispose();
    _travelerNumController.dispose();
    _billingNameController.dispose();
    _billingDocController.dispose();
    _billingAddrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle(context, 'Información Personal'),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombres*'),
              validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Apellidos*'),
              validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
            ),
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
                  initialDate: DateTime.now(),
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
            TextFormField(
              controller: _docNumberController,
              decoration: const InputDecoration(labelText: 'Nº Documento*'),
              validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
            ),
            const SizedBox(height: 16),
             TextFormField(
              controller: _docTypeController,
              decoration: const InputDecoration(labelText: 'Tipo Documento (CI, PAS)'),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Datos de Contacto y Viaje'),
            const SizedBox(height: 16),
             TextFormField(
              controller: _travelerNumController,
              decoration: const InputDecoration(labelText: 'Nº Viajero Frecuente'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.phone,
            ),
            // --- ECCIÓN DE FACTURACIÓN ---
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
                      context.read<ClientCreationBloc>().add(
                            SaveClientEvent(
                              name: _nameController.text,
                              lastName: _lastNameController.text,
                              birthDate: _selectedBirthDate,
                              documentNumber: _docNumberController.text,
                              documentType: _docTypeController.text.isNotEmpty ? _docTypeController.text : null,
                              travelerNumber: _travelerNumController.text.isNotEmpty ? _travelerNumController.text : null,
                              email: _emailController.text.isNotEmpty ? _emailController.text : null,
                              phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
                              billingName: _billingNameController.text.isNotEmpty ? _billingNameController.text : null,
                              billingDocument: _billingDocController.text.isNotEmpty ? _billingDocController.text : null,
                              billingAddress: _billingAddrController.text.isNotEmpty ? _billingAddrController.text : null,
                            ),
                          );
                    }
                  },
                  child: const Text('Guardar Cliente'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para los títulos de sección
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
