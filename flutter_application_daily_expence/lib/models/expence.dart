import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formattedDate = DateFormat.yMd();
final uuid = const Uuid().v4;

// ignore: constant_identifier_names
enum Category { Food, Transport, Shopping, Rent, Others }

// final categoryItems = {
//   Category.Food: Icons.fastfood,
//   Category.Transport: Icons.directions_bus,
//   Category.Shopping: Icons.shopping_cart,
//   Category.Rent: Icons.home,
//   Category.Others: Icons.category,
// };

Icon getCategoryIcon(Category category) {
  switch (category) {
    case Category.Food:
      return const Icon(Icons.fastfood);
    case Category.Transport:
      return const Icon(Icons.directions_bus);
    case Category.Shopping:
      return const Icon(Icons.shopping_cart);
    case Category.Rent:
      return const Icon(Icons.home);
    case Category.Others:
      return const Icon(Icons.category);
  }
}

class ExpenceModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenceModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.toString();

  String getDate() {
    return formattedDate.format(date);
  }
}
