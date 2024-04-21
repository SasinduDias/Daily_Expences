import 'package:flutter/material.dart';
import 'package:flutter_application_daily_expences/models/expence.dart';
import 'package:flutter_application_daily_expences/widgets/addNewExpences.dart';
import 'package:flutter_application_daily_expences/widgets/recycleExpencesList.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

final List<ExpenceModel> _expencesList = [
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

class _ExpencesState extends State<Expences> {
  void _openBottomOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return AddNewExpences();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expences'),
        backgroundColor: const Color.fromARGB(255, 10, 5, 83),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 92, 113, 133),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: _openBottomOverlay,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _expencesList.length,
        itemBuilder: (context, index) {
          final expence = _expencesList[index];
          return ExpenceList(expence: expence);
        },
      ),
    );
  }
}
