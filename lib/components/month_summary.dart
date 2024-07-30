import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habits/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity, // Use full width available
        height: 360, // Set the desired height
        child: HeatMap(
          startDate: createDateTimeObject(startDate),
          endDate: DateTime.now(),
          datasets: datasets,
          colorMode: ColorMode.color,
          defaultColor: Colors.grey[300],
          textColor: Colors.white,
          showColorTip: false,
          showText: true,
          scrollable: true,
          size: 30, // Reduce the size of each cell for a more compact look
          colorsets: const {
            1: Color.fromARGB(30, 2, 179, 8),
            2: Color.fromARGB(60, 2, 179, 8),
            3: Color.fromARGB(90, 2, 179, 8),
            4: Color.fromARGB(120, 2, 179, 8),
            5: Color.fromARGB(150, 2, 179, 8),
            6: Color.fromARGB(180, 2, 179, 8),
            7: Color.fromARGB(210, 2, 179, 8),
            8: Color.fromARGB(240, 2, 179, 8),
            9: Color.fromARGB(255, 2, 179, 8),
          },
          onClick: (value) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.toString())));
          },
        ),
      ),
    );
  }
}
