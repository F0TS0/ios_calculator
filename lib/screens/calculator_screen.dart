import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import 'history_screen.dart';
import 'converter_screen.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  Widget _buildButton(
    String text,
    BuildContext context, {
    Color color = CupertinoColors.systemGrey,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => context.read<CalculatorProvider>().buttonPressed(text),
      child: Container(
        alignment: Alignment.center,
        height: 75,
        width: 75,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Text(
          text,
          style: const TextStyle(fontSize: 28, color: CupertinoColors.white),
        ),
      ),
    );
  }

  Widget _buildRow(List<String> buttons, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          buttons.map((text) {
            Color color = CupertinoColors.darkBackgroundGray;
            if (text == "C") color = CupertinoColors.systemRed;
            if (text == "=") color = CupertinoColors.activeGreen;
            if (["+", "-", "×", "÷"].contains(text))
              color = CupertinoColors.activeOrange;
            return _buildButton(text, context, color: color);
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = context.watch<CalculatorProvider>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("iOS Calculator"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text(
                "Convert",
                style: TextStyle(color: CupertinoColors.activeBlue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ConverterScreen(),
                  ),
                );
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text(
                "History",
                style: TextStyle(color: CupertinoColors.activeBlue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              calculatorProvider.output,
              style: const TextStyle(
                fontSize: 60,
                color: CupertinoColors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              _buildRow(["C", "+", "-", "÷"], context),
              _buildRow(["7", "8", "9", "×"], context),
              _buildRow(["4", "5", "6", "="], context),
              _buildRow(["1", "2", "3", "0"], context),
            ],
          ),
        ],
      ),
    );
  }
}
