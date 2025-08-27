import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/injection_container.dart';
import '../bloc/client_creation/client_creation_bloc.dart';
import '../bloc/client_list_bloc.dart';

/// ---
/// /// [ClientCreationPage] es la pantalla que contiene el formulario para
/// /// crear un nuevo cliente.
/// ///
/// /// Utiliza un [GlobalKey<FormState>] para gestionar la validación y el estado
/// /// del formulario.
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
/// /// [ClientCreationForm] es el widget que contiene la lógica y los campos
/// /// del formulario.
/// ///
/// /// Es un [StatefulWidget] para poder gestionar los controladores de texto.
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
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombres',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Apellidos',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese los apellidos';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Por favor, ingrese un correo válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Teléfono (Opcional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32),
            BlocBuilder<ClientCreationBloc, ClientCreationState>(
              builder: (context, state) {
                if (state is ClientCreationLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Despacha el evento al BLoC con los datos del formulario.
                      context.read<ClientCreationBloc>().add(
                            SaveClientEvent(
                              name: _nameController.text,
                              lastName: _lastNameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text.isNotEmpty
                                  ? _phoneController.text
                                  : null,
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
}
