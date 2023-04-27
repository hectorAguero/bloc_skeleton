import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:new_flutter_template/src/sample_feature/sample_item_details_view.dart';
import 'package:new_flutter_template/src/sample_feature/sample_item_list_view.dart';
import 'package:new_flutter_template/src/settings/settings_view.dart';
import 'package:new_flutter_template/src/settings/theme_cubit.dart';
import 'package:new_flutter_template/src/settings/theme_state.dart';

/// Main app widget.
class MyApp extends StatelessWidget {
  /// Constructor.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    setAndroidNavigationBar();
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) => MaterialApp(
        restorationScopeId: 'app',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
        ],
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: state.seedColor),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: state.seedColor,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: state.themeMode,
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case SettingsView.routeName:
                  return const SettingsView();
                case SampleItemDetailsView.routeName:
                  return const SampleItemDetailsView();
                case SampleItemListView.routeName:
                default:
                  return const SampleItemListView();
              }
            },
          );
        },
      ),
    );
  }
}

/// Enable the edge to edge mode for Android, to show transparent status bar
/// refer to this issue https://github.com/flutter/flutter/issues/119465
void setAndroidNavigationBar() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      //NavigationBar
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarIconBrightness: Brightness.dark,
      //StatusBar
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
