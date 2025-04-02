// pages/calculator_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show GridView; // for simpler 4x4 layout
import 'package:ios_calculator/controllers/calculator_controller.dart';
import 'package:ios_calculator/repositories/history_repository.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  late CalculatorController _calcController;

  @override
  void initState() {
    super.initState();
    final repo = HistoryRepository();
    _calcController = CalculatorController(repo);
  }

  void _onPress(String label) {
    if (label == "=") {
      _calcController.evaluateExpression().then((_) {
        setState(() {});
      });
    } else {
      switch (label) {
        case "÷":
          _calcController.append("/");
          break;
        case "×":
          _calcController.append("*");
          break;
        default:
          _calcController.append(label);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Calculator"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text("History"),
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text("Convert"),
              onPressed: () {
                Navigator.pushNamed(context, '/converter');
              },
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Expression display
            Container(
              width: double.infinity,
              color: CupertinoColors.systemGrey6,
              padding: const EdgeInsets.all(16),
              child: Text(
                _calcController.expression,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            // Buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  _key("7"), _key("8"), _key("9"), _key("÷"),
                  _key("4"), _key("5"), _key("6"), _key("×"),
                  _key("1"), _key("2"), _key("3"), _key("-"),
                  _key("0"), _key("."), _key("="), _key("+"),
                ],
              ),
            ),
            // Clear
            CupertinoButton(
              child: const Text("Clear"),
              onPressed: () {
                setState(() {
                  _calcController.clear();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _key(String label) {
    return GestureDetector(
      onTap: () => _onPress(label),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey4,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(label, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}