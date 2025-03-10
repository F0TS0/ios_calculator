import 'package:flutter/cupertino.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _kmController = TextEditingController();
  String _result = "";

  void _convert() {
    setState(() {
      double? km = double.tryParse(_kmController.text);
      if (km == null) {
        _result = "Invalid input";
        return;
      }
      double miles = km * 0.621371;
      _result = "$km km = ${miles.toStringAsFixed(2)} miles";
    });
  }

  void _clearInput() {
    setState(() {
      _kmController.clear();
      _result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("KM to Miles Converter"),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            "Back",
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.clear_circled,
            color: CupertinoColors.systemRed,
          ),
          onPressed: _clearInput,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoTextField(
              controller: _kmController,
              placeholder: "Enter kilometers",
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
              onChanged:
                  (_) => _convert(), // Convert automatically on input change
              decoration: BoxDecoration(
                color: CupertinoColors.darkBackgroundGray,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              child: const Text("Convert"),
              onPressed: _convert,
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
