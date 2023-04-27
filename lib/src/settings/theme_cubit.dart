import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_template/src/settings/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cubit to handle the theme state.
class ThemeCubit extends Cubit<ThemeState> {
  /// Constructor, initializes the state with default values
  /// and loads the settings from SharedPreferences.
  ThemeCubit()
      : super(
          const ThemeState(
            themeMode: ThemeMode.system,
            seedColor: Colors.blue,
          ),
        ) {
    loadSettings();
  }

  /// SharedPreferences instance to use.
  late final SharedPreferences sharedPreferences;

  /// Loads the settings from SharedPreferences.
  Future<void> loadSettings() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final themeMode = sharedPreferences.getInt('theme_mode') ?? 0;
    final seedColor =
        sharedPreferences.getInt('seed_color') ?? Colors.blue.value;
    emit(
      ThemeState(
        themeMode: ThemeMode.values[themeMode],
        seedColor: Color(seedColor),
      ),
    );
  }

  /// Updates the seed color and saves it to SharedPreferences.
  Future<void> updateSeedColor(Color newSeedColor) async {
    await sharedPreferences.setInt('seed_color', newSeedColor.value);
    emit(state.copyWith(seedColor: newSeedColor));
  }

  /// Updates the theme mode and saves it to SharedPreferences.
  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    await sharedPreferences.setInt('theme_mode', newThemeMode.index);
    emit(state.copyWith(themeMode: newThemeMode));
  }
}
