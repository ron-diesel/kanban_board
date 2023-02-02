import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kanban_board/core/app_colors.dart';
import 'package:kanban_board/core/app_routes.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/di/base_di_module.dart';

const _locale = 'en';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = _locale;
  await initializeDateFormatting();
  await initCoreDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterial,
        canvasColor: AppColors.surface,
      ),
      routes: AppRoutes.routes.map(
        (key, value) => MapEntry(
          key,
          (_) => Container(
            color: AppColors.backgroundVariant,
            child: SafeArea(child: Builder(builder: value)),
          ),
        ),
      ),
    );
  }
}
