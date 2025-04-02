// controllers/calculator_controller.dart
import 'package:math_expressions/math_expressions.dart';
import 'package:ios_calculator/models/history_entry.dart';
import 'package:ios_calculator/repositories/history_repository.dart';

class CalculatorController {
  final HistoryRepository _repo;
  String expression = ""; // current user input

  CalculatorController(this._repo);

  // Evaluate the expression, save result into DB
  Future<String> evaluateExpression() async {
    if (expression.isEmpty) return "";

    try {
      // For advanced usage, you can use ShuntingYardParser instead of Parser()
      final parser = Parser();
      final exp = parser.parse(expression);
      final eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      final resultString = "$expression=$eval";

      // Save to DB
      await _repo.insertEntry(
        HistoryEntry(
          content: resultString,
          createdAt: DateTime.now(),
        ),
      );
      // Return the numeric result as string
      expression = eval.toString();
      return expression;
    } catch (e) {
      expression = "Error";
      return expression;
    }
  }

  // Append digits/operators to the expression
  void append(String char) {
    if (expression == "Error") {
      expression = "";
    }
    expression += char;
  }

  // Clear
  void clear() {
    expression = "";
  }
}