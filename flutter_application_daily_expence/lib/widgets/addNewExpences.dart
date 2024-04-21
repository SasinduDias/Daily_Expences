import 'dart:ffi';

import 'package:flutter_application_daily_expences/models/expence.dart'
    as expence;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddNewExpences extends StatefulWidget {
  const AddNewExpences({super.key});

  @override
  State<AddNewExpences> createState() => _AddNewExpencesState();
}

class _AddNewExpencesState extends State<AddNewExpences> {
  final _titleController = TextEditingController();
  final _amount = TextEditingController();
  expence.Category _selectedCategory = expence.Category.Food;

  DateTime _selectedDate = DateTime.now();

  void _validateForm() {
    final title = _titleController.text.trim();
    final amount = _amount.text.trim();

    if (title.isEmpty || amount.isEmpty) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Basic dialog title'),
            content: const Text(
              'A dialog is a type of modal window that\n'
              'appears in front of app content to\n'
              'provide critical information, or prompt\n'
              'for a decision to be made.',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Disable'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Enable'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amount.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        //text fields title
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              labelText: 'Title',
              hintText: 'Enter the title of the expence',
            ),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _amount,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Amount',
                    hintText: 'Enter the amount of the expence',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
              ),

              //date picker
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                    Text(expence.formattedDate.format(_selectedDate),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1,
                              DateTime.now().month, DateTime.now().day),
                          lastDate: DateTime(DateTime.now().year + 5,
                              DateTime.now().month, DateTime.now().day),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            setState(() {
                              _selectedDate = selectedDate;
                            });
                          }
                        });
                      },
                    ),
                  ]))
            ],
          ),

          //dropDown and buttons
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                DropdownButton(
                  padding: const EdgeInsets.all(10),
                  value: _selectedCategory,
                  items: expence.Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //close button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Close'),
                    ),

                    const SizedBox(width: 10),

                    //save button
                    ElevatedButton(
                      onPressed: _validateForm,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Text('Save'),
                    )
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
