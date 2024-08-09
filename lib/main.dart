import 'package:login_app_test/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(
    MaterialApp(
      home: MainScreen(),
    ),
  );
}