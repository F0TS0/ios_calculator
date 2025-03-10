import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'dart:developer'; // ✅ Debugging Log

class CalculatorProvider extends ChangeNotifier {
  String _output = "0";
  String _input = "";
  double? _num1;
  double? _num2;
  String? _operator;

  String get output => _output;

  void buttonPressed(String value) async {
    if (value == "C") {
      _clear();
    } else if (value == "=") {
      _calculateResult();
    } else if (["+", "-", "×", "÷"].contains(value)) {
      _setOperator(value);
    } else {
      _appendNumber(value);
    }
    notifyListeners();
  }

  void _clear() {
    _output = "0";
    _input = "";
    _num1 = null;
    _num2 = null;
    _operator = null;
  }

  void _appendNumber(String number) {
    if (_input == "0") {
      _input = number;
    } else {
      _input += number;
    }
    _output = _input;
  }

  void _setOperator(String operator) {
    if (_input.isEmpty) return;
    _num1 = double.tryParse(_input);
    _operator = operator;
    _input = "";
  }

  void _calculateResult() async {
    if (_num1 == null || _operator == null || _input.isEmpty) return;

    _num2 = double.tryParse(_input);
    if (_num2 == null) return;

    String expression = "$_num1 $_operator $_num2";
    double result = 0;

    switch (_operator) {
      case "+":
        result = _num1! + _num2!;
        break;
      case "-":
        result = _num1! - _num2!;
        break;
      case "×":
        result = _num1! * _num2!;
        break;
      case "÷":
        result = _num2 != 0 ? (_num1! / _num2!) : double.nan;
        break;
    }

    _output = result.isNaN ? "Error" : result.toString();
    _input = _output;
    _num1 = result;
    _operator = null;

    if (!result.isNaN) {
      log("Saving to history: $expression = $_output"); // ✅ Debugging Log
      await DBHelper.insertHistory(expression, _output);
    }
  }
}
