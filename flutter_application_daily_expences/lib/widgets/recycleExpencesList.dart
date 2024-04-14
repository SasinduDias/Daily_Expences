// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_daily_expences/models/expence.dart';

class ExpenceList extends StatelessWidget {
  const ExpenceList({super.key, required this.expence});

  final ExpenceModel expence;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
      child: ListTile(
          tileColor: const Color.fromARGB(255, 92, 113, 133),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          title: Text(expence.title),
          subtitle: Text('${expence.category} - ${expence.getDate()}'),
          trailing: Text(expence.amount.toStringAsFixed(2)),
          leading: getCategoryIcon(expence.category),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
