import 'package:flutter/material.dart';

@immutable

/// State to use across the app inside the respective cubit.
class ThemeState {
  /// Constructor with required values.
  const ThemeState({
    required this.themeMode,
    required this.seedColor,
  });

  /// ThemeMode to use.
  final ThemeMode themeMode;

  /// Color to provide to the ColorScheme and the theme.
  final Color seedColor;

  /// Creates a copy of the current state.
  ThemeState copyWith({
    ThemeMode? themeMode,
    Color? seedColor,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      seedColor: seedColor ?? this.seedColor,
    );
  }

  @override
  String toString() =>
      'ThemeState { themeMode: $themeMode, seedColor: $seedColor }';

  @override
  bool operator ==(covariant ThemeState other) =>
      other.seedColor == seedColor && other.themeMode == themeMode;

  @override
  int get hashCode => seedColor.hashCode ^ themeMode.hashCode;
}
