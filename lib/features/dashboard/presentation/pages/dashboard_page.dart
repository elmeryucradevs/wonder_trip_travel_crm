import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonder_trip_travel_crm/core/config/injection_container.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/presentation/widgets/birthday_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardBloc>()..add(LoadDashboardData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DashboardLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(8.0), // Padding para la lista
                child: Column(
                  children: [
                    BirthdayCard(clients: state.birthdayClients),
                    // Aquí irán las otras tarjetas (vuelos, etc.)
                  ],
                ),
              );
            }
            if (state is DashboardFailure) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}