import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_template/src/settings/theme_cubit.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  /// Constructor.
  const SettingsView({super.key});

  /// Route name for the SettingsView.
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            // Glue the SettingsController to the theme selection DropdownButton
            //
            // When a user selects a theme from the dropdown list, the
            // SettingsController is updated, which rebuilds the MaterialApp.
            child: DropdownButton<ThemeMode>(
              // Read the selected themeMode from the controller
              value: controller.state.themeMode,
              // Call the updateThemeMode method when the user selects a theme
              onChanged: (value) async =>
                  context.read<ThemeCubit>().updateThemeMode(value!),
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            ),
          ),
          Wrap(
            children: [
              for (final color in Colors.primaries)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () async =>
                        context.read<ThemeCubit>().updateSeedColor(color),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color,
                        border: controller.state.seedColor.value == color.value
                            ? Border.all(
                                width: 4,
                                color: Theme.of(context).colorScheme.onSurface,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Wrap(
            spacing: 4,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Button'),
              ),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Button'),
              ),
              FilledButton.tonalIcon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Button'),
              )
            ],
          )
        ],
      ),
    );
  }
}
