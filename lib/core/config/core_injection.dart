import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_trip_travel_crm/core/theme/bloc/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> initCore() async {
  // BLoC
  sl.registerLazySingleton(() => ThemeBloc()..add(ThemeLoadStarted()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}