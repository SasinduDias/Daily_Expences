import 'package:flutter/material.dart';
import 'package:flutter_application_daily_expences/models/expence.dart';
import 'package:flutter_application_daily_expences/server/database.dart';
import 'package:flutter_application_daily_expences/widgets/addNewExpences.dart';
import 'package:flutter_application_daily_expences/widgets/recycleExpencesList.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  final _expencesBox = Hive.box('expences');
  Database database = Database();

  void newExpence(ExpenceModel expenceModel) {
    setState(() {
      database.expencesList.add(expenceModel);
      database.saveData();
      totalValus();
    });
  }

  void _removeExpenceAt(int index) {
    ExpenceModel expenceRemoved = database.expencesList[index];
    setState(() {
      database.expencesList.removeAt(index);
      database.saveData();
      totalValus();
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expence removed'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            database.expencesList.insert(index, expenceRemoved);
            database.saveData();
            totalValus();
          });
        },
      ),
    ));
  }

  void _openBottomOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return AddNewExpences(onAddExpence: newExpence);
        });
  }

  Map<String, double> dataMap = {
    "Food": 0,
    "Transport": 0,
    "Shopping": 0,
    "Rent": 0,
    "Others": 0,
  };

  double valFood = 0;
  double valTransport = 0;
  double valShopping = 0;
  double valRent = 0;
  double valOthers = 0;

  void totalValus() {
    double valFoodTotal = 0;
    double valTransportTotal = 0;
    double valShoppingTotal = 0;
    double valRentTotal = 0;
    double valOthersTotal = 0;

    for (var i = 0; i < database.expencesList.length; i++) {
      if (database.expencesList[i].category == Category.Food) {
        valFoodTotal += database.expencesList[i].amount;
      } else if (database.expencesList[i].category == Category.Transport) {
        valTransportTotal += database.expencesList[i].amount;
      } else if (database.expencesList[i].category == Category.Shopping) {
        valShoppingTotal += database.expencesList[i].amount;
      } else if (database.expencesList[i].category == Category.Rent) {
        valRentTotal += database.expencesList[i].amount;
      } else if (database.expencesList[i].category == Category.Others) {
        valOthersTotal += database.expencesList[i].amount;
      }
    }

    setState(() {
      valFood = valFoodTotal;
      valTransport = valTransportTotal;
      valShopping = valShoppingTotal;
      valRent = valRentTotal;
      valOthers = valOthersTotal;
    });

    dataMap = {
      "Food": valFood,
      "Transport": valTransport,
      "Shopping": valShopping,
      "Rent": valRent,
      "Others": valOthers,
    };
  }

  @override
  void initState() {
    super.initState();

    if (_expencesBox.get('expences') == null) {
      database.createInitialDatabase();
      totalValus();
    } else {
      database.loadData();
      totalValus();
    }
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
              icon: const Icon(Icons.add),
              onPressed: _openBottomOverlay,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //pie chart
          PieChart(dataMap: dataMap),
          Expanded(
            child: ListView.builder(
              itemCount: database.expencesList.length,
              itemBuilder: (context, index) {
                final expence = database.expencesList[index];
                return Dismissible(
                  key: UniqueKey(),
                  // key: Key(expence.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      _removeExpenceAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  child: ExpenceList(expence: expence),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
