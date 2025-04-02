// main.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:ios_calculator/pages/calculator_page.dart';
import 'package:ios_calculator/pages/converter_page.dart';
import 'package:ios_calculator/pages/history_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'iOS Calculator',
      initialRoute: '/',
      routes: {
        '/': (context) => const CalculatorPage(),
        '/converter': (context) => const ConverterPage(),
        '/history': (context) => const HistoryPage(),
      },
    );
  }
}