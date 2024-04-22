import 'package:flutter/material.dart';
import 'package:flutter_application_daily_expences/models/expence.dart';
import 'package:flutter_application_daily_expences/pages/expences.dart';
import 'package:flutter_application_daily_expences/server/categoryAdapter.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenceModelAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox('expences');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Expences());
  }
}
