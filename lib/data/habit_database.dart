import 'package:habits/datetime/date_time.dart';
import 'package:hive/hive.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase{
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};
  //create initial default data
  void createDefaultData(){
    todaysHabitList = [
      ['Run', false],
      ['Read', false],

    ];
    _myBox.put("START_DATE", todaysDateFormatted());
  }
//load  data if it  already exists
  void loadData(){
    //if its a new day , get  habit  list  from  databse
    if(_myBox.get(todaysDateFormatted())== null){
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      // set all  hbit completed  to  false  since  its  a  new
      for(int i =0; i<todaysHabitList.length; i++){
        todaysHabitList[i][1] = false;
      }


    }else{
      todaysHabitList = _myBox.get(todaysDateFormatted());

    }

  }
//update  the database
  void updateData(){
    //update todays  entry
    _myBox.put(todaysDateFormatted(), todaysHabitList);
    //update  univwrsal  habit
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);
    //calculate
    calculateHabitPercentage();

//load heat  map
    loadHeatMap();
  }
  void calculateHabitPercentage(){
    int countCompleted = 0 ;
    for(int i =0; i< todaysHabitList.length; i++){
      if(todaysHabitList[i][1] ==true){
        countCompleted++;
      }
    }
    String percent =todaysHabitList.isEmpty?'0.0'
        : (countCompleted / todaysHabitList.length).toStringAsFixed(1);
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}",percent);
  }
  void  loadHeatMap(){
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for(int i = 0; i< daysInBetween +1; i++ ){
      String yyyymmdd = convertDateTimeToString
        (startDate.add(Duration(days: i)),
      );
      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd")?? "0.0",
      );

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;
      final percentForEachDay = <DateTime, int>{
        DateTime(year,month,day):(10*strengthAsPercent).toInt(),

      };
      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }

}