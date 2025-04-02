// pages/converter_page.dart
import 'package:flutter/cupertino.dart';
import 'package:ios_calculator/controllers/converter_controller.dart';
import 'package:ios_calculator/repositories/history_repository.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _kmController = TextEditingController();
  late ConverterController _converterController;

  String resultText = "";

  @override
  void initState() {
    super.initState();
    final repo = HistoryRepository();
    _converterController = ConverterController(repo);
  }

  Future<void> _convert() async {
    final kmStr = _kmController.text.trim();
    if (kmStr.isEmpty) return;

    final kmValue = double.tryParse(kmStr);
    if (kmValue == null) {
      setState(() {
        resultText = "Invalid input!";
      });
      return;
    }

    final res = await _converterController.convertKmToMiles(kmValue);
    setState(() {
      resultText = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("KM → Miles"),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _kmController,
                placeholder: "Enter kilometers",
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              CupertinoButton.filled(
                onPressed: _convert,
                child: const Text("Convert"),
              ),
              const SizedBox(height: 16),
              Text(resultText),
              const Spacer(),
              CupertinoButton(
                child: const Text("Back"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}