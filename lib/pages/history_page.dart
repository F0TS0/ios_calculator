import 'package:flutter/cupertino.dart';
import 'package:ios_calculator/models/history_entry.dart';
import 'package:ios_calculator/repositories/history_repository.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryRepository _repo = HistoryRepository();
  List<HistoryEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final data = await _repo.getAllEntries();
    setState(() {
      _entries = data;
    });
  }

  Future<void> _clearAll() async {
    await _repo.clearHistory();
    await _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("History"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text("Clear"),
          onPressed: _clearAll,
        ),
      ),
      child: SafeArea(
        child:
            _entries.isEmpty
                ? const Center(child: Text("No history"))
                : ListView.builder(
                  itemCount: _entries.length,
                  itemBuilder: (context, index) {
                    final item = _entries[index];
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.content,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.createdAt.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.inactiveGray,
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: CupertinoColors.separator,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
