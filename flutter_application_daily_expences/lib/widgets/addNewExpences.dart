import 'package:flutter/material.dart';

class AddNewExpences extends StatefulWidget {
  const AddNewExpences({super.key});

  @override
  State<AddNewExpences> createState() => _AddNewExpencesState();
}

class _AddNewExpencesState extends State<AddNewExpences> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        TextField(
          // controller: _titleController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            labelText: 'Title',
            hintText: 'Enter the title of the expence',
          ),
          keyboardType: TextInputType.text,
          maxLength: 50,
        ),
      ],
    );
  }
}
