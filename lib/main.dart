import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_template/src/app.dart';
import 'package:new_flutter_template/src/settings/theme_cubit.dart';

void main() async {
  runApp(
    BlocProvider(
      lazy: false,
      create: (context) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}
