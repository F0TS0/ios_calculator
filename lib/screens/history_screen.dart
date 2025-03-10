import 'package:flutter/cupertino.dart';
import '../database/db_helper.dart';
import 'package:intl/intl.dart'; // ✅ FIXED: Import Intl package

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    List<Map<String, dynamic>> history = await DBHelper.getHistory();
    setState(() {
      _history = history;
    });
  }

  void _clearHistory() async {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: const Text("Clear History"),
            content: const Text("Are you sure you want to delete all history?"),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text("Clear"),
                onPressed: () async {
                  await DBHelper.clearHistory();
                  Navigator.pop(context);
                  _loadHistory();
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat(
      "MMM d, yyyy • h:mm a",
    ).format(dateTime); // ✅ FIXED: Use DateFormat correctly
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("History"),
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
          child: const Text(
            "Clear",
            style: TextStyle(color: CupertinoColors.destructiveRed),
          ),
          onPressed: _clearHistory,
        ),
      ),
      child:
          _history.isEmpty
              ? const Center(
                child: Text(
                  "No history yet",
                  style: TextStyle(
                    fontSize: 18,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              )
              : ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final item = _history[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: CupertinoListTile(
                      title: Text(
                        "${item['expression']} = ${item['result']}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        _formatTimestamp(item['timestamp']),
                        style: const TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
