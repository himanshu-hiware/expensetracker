import 'package:expensetracker/BarGraph/Bar_graph.dart';
import 'package:expensetracker/DaytTme/datetime_helper.dart';
import 'package:expensetracker/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class expense_summary extends StatelessWidget {
  final DateTime startofweek;
    const expense_summary({
    super.key,
   required this.startofweek,
  });
double calculateMax(
    Expense_data value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    ){
  double? max =100;

  List<double> values =[
    value.calculateDailyExpense()[sunday] ?? 0,
    value.calculateDailyExpense()[monday] ?? 0,
    value.calculateDailyExpense()[tuesday] ?? 0,
    value.calculateDailyExpense()[wednesday] ?? 0,
    value.calculateDailyExpense()[friday] ?? 0,
    value.calculateDailyExpense()[saturday] ?? 0,

  ];
  values.sort();
  max = values.last*1.5;
  return (max==0)?100:max;
}
String calculateSum(
    Expense_data value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    ){
  double? max =100;

  List<double> values =[
    value.calculateDailyExpense()[sunday] ?? 0,
    value.calculateDailyExpense()[monday] ?? 0,
    value.calculateDailyExpense()[tuesday] ?? 0,
    value.calculateDailyExpense()[wednesday] ?? 0,
    value.calculateDailyExpense()[friday] ?? 0,
    value.calculateDailyExpense()[saturday] ?? 0,

  ];
  double sum = 0;
  for(int i=0;i<values.length;i++) {
      sum += values[i];
  }
  return sum.toStringAsFixed(2);
}
  @override
  Widget build(BuildContext context) {

    String sunday = convertDayTimeToString(startofweek.add(const Duration(days: 0)));
    String monday = convertDayTimeToString(startofweek.add(const Duration(days: 1)));
    String tuesday = convertDayTimeToString(startofweek.add(const Duration(days: 2)));
    String wednesday = convertDayTimeToString(startofweek.add(const Duration(days: 3)));
    String thursday = convertDayTimeToString(startofweek.add(const Duration(days: 4)));
    String friday = convertDayTimeToString(startofweek.add(const Duration(days: 5)));
    String saturday = convertDayTimeToString(startofweek.add(const Duration(days: 6)));
    return  Consumer<Expense_data>(builder: (context,value,child)=>Column(
      children: [

        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              const Text('Week Total: ',style: TextStyle(fontWeight: FontWeight.bold),),
              Text('\$'+calculateSum(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)),
            ],
          ),
        ),
        SizedBox(
          height:200,
          child: MyBarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
              sunAmount:value.calculateDailyExpense()[sunday] ?? 0,
              monAmount: value.calculateDailyExpense()[monday] ?? 0,
              tueAmount: value.calculateDailyExpense()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpense()[wednesday] ?? 0,
              thurAmount:value.calculateDailyExpense()[thursday] ?? 0,
              friAmount: value.calculateDailyExpense()[friday] ?? 0,
              satAmount: value.calculateDailyExpense()[saturday] ?? 0,
          ),

        ),
      ],
    ),);
  }
}
