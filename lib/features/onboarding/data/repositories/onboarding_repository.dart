import 'package:shared_preferences/shared_preferences.dart';

/// ---
/// /// [OnboardingRepository] gestiona el estado de persistencia del flujo
/// /// de incorporación (onboarding).
/// ///
/// /// Utiliza SharedPreferences para recordar si el usuario ya ha completado
/// /// el onboarding, evitando que se muestre en inicios posteriores de la app.
/// ---
class OnboardingRepository {
  final SharedPreferences _prefs;
  static const _keyHasSeenOnboarding = 'has_seen_onboarding';

  OnboardingRepository(this._prefs);

  /// Devuelve `true` si el usuario ya ha completado el onboarding.
  Future<bool> hasSeenOnboarding() async {
    return _prefs.getBool(_keyHasSeenOnboarding) ?? false;
  }

  /// Marca el onboarding como completado.
  Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(_keyHasSeenOnboarding, true);
  }
}