import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeModeKey = 'themeMode';

  ThemeBloc() : super(const ThemeState()) {
    on<ThemeLoadStarted>(_onLoadStarted);
    on<ThemeModeChanged>(_onThemeChanged);
  }

  Future<void> _onLoadStarted(ThemeLoadStarted event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeModeKey) ?? ThemeMode.system.index;
    final themeMode = ThemeMode.values[themeIndex];
    emit(ThemeState(themeMode: themeMode));
  }

  Future<void> _onThemeChanged(ThemeModeChanged event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, event.themeMode.index);
    emit(ThemeState(themeMode: event.themeMode));
  }
}