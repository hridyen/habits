import 'package:flutter/material.dart';
import 'package:habits/components/month_summary.dart';
import 'package:habits/data/habit_database.dart';
import 'package:hive/hive.dart';

import '../components/habit_tile.dart';
import '../components/my_fab.dart';
import '../components/my_alertbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    db.updateData();
    super.initState();
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateData();
  }

  final _newHabitNameController = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertbox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
          hintText: "Enter a Habit",
        );
      },
    );
  }

  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
      _newHabitNameController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  void openHabitSettings(int index) {
    _newHabitNameController.text = db.todaysHabitList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertbox(
          controller: _newHabitNameController,
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
          hintText: db.todaysHabitList[index][0],
        );
      },
    );
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateData();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MonthlySummary(
              datasets: db.heatMapDataSet,
              startDate: _myBox.get("START_DATE"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: db.todaysHabitList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: HabitTile(
                      habitName: db.todaysHabitList[index][0],
                      habitCompleted: db.todaysHabitList[index][1],
                      onChanged: (value) => checkBoxTapped(value, index),
                      settingsTapped: (context) => openHabitSettings(index),
                      deleteTapped: (context) => deleteHabit(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
