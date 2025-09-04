import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder_trip_travel_crm/core/theme/app_colors.dart';

class CreateQuoteCard extends StatelessWidget {
  const CreateQuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.goNamed('newQuote'),
        borderRadius: BorderRadius.circular(16),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.request_quote_outlined, color: AppColors.primaryLight, size: 32),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Crear Cotización Rápida',
                  style: TextStyle(
                        color: AppColors.fontTitleLight,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}