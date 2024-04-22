import 'package:flutter_application_daily_expences/models/expence.dart';
import 'package:hive/hive.dart';

class Database {
  final _expencesBox = Hive.box('expences');

  List<ExpenceModel> expencesList = [];

  void createInitialDatabase() {
    expencesList = [
      ExpenceModel(
        title: 'Groceries',
        amount: 100.0,
        date: DateTime.now(),
        category: Category.Food,
      ),
      ExpenceModel(
        title: 'Transport',
        amount: 50.0,
        date: DateTime.now(),
        category: Category.Transport,
      ),
      ExpenceModel(
        title: 'Shoes',
        amount: 200.0,
        date: DateTime.now(),
        category: Category.Shopping,
      ),
      ExpenceModel(
        title: 'Rent',
        amount: 500.0,
        date: DateTime.now(),
        category: Category.Rent,
      ),
      ExpenceModel(
        title: 'Others',
        amount: 100.0,
        date: DateTime.now(),
        category: Category.Others,
      ),
    ];
  }

  void loadData() {
    final dynamic data = _expencesBox.get("expences");

    if (data != null && data is List<dynamic>) {
      expencesList = data.cast<ExpenceModel>().toList();
    }
  }

  Future<void> saveData() async {
    await _expencesBox.put("expences", expencesList);
  }
}
