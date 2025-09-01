import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonder_trip_travel_crm/core/theme/bloc/theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Text('Configuración', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return SegmentedButton<ThemeMode>(
                segments: const <ButtonSegment<ThemeMode>>[
                  ButtonSegment<ThemeMode>(value: ThemeMode.light, label: Text('Claro'), icon: Icon(Icons.light_mode_outlined)),
                  ButtonSegment<ThemeMode>(value: ThemeMode.system, label: Text('Sistema'), icon: Icon(Icons.brightness_auto_outlined)),
                  ButtonSegment<ThemeMode>(value: ThemeMode.dark, label: Text('Oscuro'), icon: Icon(Icons.dark_mode_outlined)),
                ],
                selected: {state.themeMode},
                onSelectionChanged: (Set<ThemeMode> newSelection) {
                  context.read<ThemeBloc>().add(ThemeModeChanged(newSelection.first));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}