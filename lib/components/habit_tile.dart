import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            // Settings
            SlidableAction(
              onPressed: settingsTapped,
              backgroundColor: Colors.blueGrey.shade800,
              icon: Icons.settings,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              label: 'Settings',
            ),
            // Deletion
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red.shade800,
              icon: Icons.delete,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.green.shade700,
                checkColor: Colors.white,
                value: habitCompleted,
                onChanged: onChanged,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  habitName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
