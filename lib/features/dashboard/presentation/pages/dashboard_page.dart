import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder_trip_travel_crm/core/config/injection_container.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:wonder_trip_travel_crm/features/dashboard/presentation/widgets/birthday_card.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/upcoming_flights_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardBloc>()..add(LoadDashboardData()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DashboardLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<DashboardBloc>().add(LoadDashboardData());
                },
                child: ListView(
                  padding: const EdgeInsets.all(8.0), // Padding para la lista
                  children: [ 
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Navega a la ruta de creación de cliente
                              context.goNamed('newClient');
                            },
                            icon: const Icon(Icons.person_add_alt_1),
                            label: const Text('Nuevo Cliente'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Para crear un boleto, primero debemos seleccionar un cliente.
                              // Por lo tanto, la acción correcta es llevar al usuario a la lista de clientes.
                              context.goNamed('clients');
                            },
                            icon: const Icon(Icons.airplane_ticket),
                            label: const Text('Nuevo Boleto'),
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentLight),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    StatsCard(
                      clientCount: state.totalClients,
                      ticketCount: state.totalTickets,
                    ),
                    const SizedBox(height: 8),
                    RecentActivityCard(clients: state.recentClients),
                    const SizedBox(height: 8),
                    BirthdayCard(clients: state.birthdayClients),
                    const SizedBox(height: 8),
                    UpcomingFlightsCard(tickets: state.upcomingFlights),
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
    );
  }
}