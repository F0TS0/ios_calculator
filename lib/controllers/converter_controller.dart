// controllers/converter_controller.dart
import 'package:ios_calculator/models/history_entry.dart';
import 'package:ios_calculator/repositories/history_repository.dart';

class ConverterController {
  final HistoryRepository _repo;

  ConverterController(this._repo);

  Future<String> convertKmToMiles(double kmValue) async {
    final miles = kmValue * 0.621371;
    final resultString =
        "${kmValue.toStringAsFixed(2)} km = ${miles.toStringAsFixed(2)} miles";

    // Insert into DB
    await _repo.insertEntry(
      HistoryEntry(
        content: resultString,
        createdAt: DateTime.now(),
      ),
    );
    return resultString;
  }
}