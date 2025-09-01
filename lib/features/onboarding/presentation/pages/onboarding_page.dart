import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wonder_trip_travel_crm/core/config/injection_container.dart';
import 'package:wonder_trip_travel_crm/features/onboarding/data/repositories/onboarding_repository.dart';
import 'package:wonder_trip_travel_crm/features/onboarding/presentation/widgets/onboarding_step_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _onboardingSteps = [
    const OnboardingStepWidget(
      imagePath: '',
      title: 'Bienvenido a Wonder Trip CRM',
      description: 'Tu asistente de viajes todo en uno. Gestiona clientes y boletos con facilidad.',
    ),
    const OnboardingStepWidget(
      imagePath: '',
      title: 'Clientes al Alcance de tu Mano',
      description: 'Crea, edita y busca perfiles de clientes en segundos. Nunca pierdas un detalle.',
    ),
    const OnboardingStepWidget(
      imagePath: '',
      title: 'Boletos Sin Complicaciones',
      description: 'Registra boletos aéreos y terrestres, maneja canjes y visualiza itinerarios completos.',
    ),
  ];
  
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() async {
    final onboardingRepo = sl<OnboardingRepository>();
    await onboardingRepo.setOnboardingCompleted();
    if (mounted) {
      context.goNamed('dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentPage == _onboardingSteps.length - 1;
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: _onboardingSteps,
              ),
            ),
            DotsIndicator(
              dotsCount: _onboardingSteps.length,
              position: _currentPage.toDouble(),
              decorator: DotsDecorator(
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: const Text('Saltar'),
                  ),
                  ElevatedButton(
                    onPressed: isLastPage ? _completeOnboarding : () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text(isLastPage ? 'Comenzar' : 'Siguiente'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}