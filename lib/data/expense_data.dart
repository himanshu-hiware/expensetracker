import 'package:expensetracker/DaytTme/datetime_helper.dart';
import 'package:expensetracker/data/hive_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/expense_items.dart';

class Expense_data extends ChangeNotifier{
  // list of all expense
  List<Expense_items> overallList=[];

  // get list
  List<Expense_items> getList() { return overallList;}

  //prepare data to display
  final db = HiveDB();
  void preparedata(){
    if(db.readData().isNotEmpty){
      overallList= db.readData();
    }
  }
  // add list
void addexpense(Expense_items newItem){
    overallList.add(newItem);

    notifyListeners();
    db.saveDate(overallList);
}
  // delete list
  void deleteexpense(Expense_items Item){
    overallList.remove(Item);

    notifyListeners();
    db.saveDate(overallList);
  }
  // get weekday  ( mon ,tue , etc) from a datetime object
  String getDayName(DateTime dateTime){
    switch(dateTime.weekday){
      case 1:
          return 'Mon';
      case 2:
          return 'Tue';
      case 3:
          return 'Wed';
      case 4:
          return 'Thu';
      case 5:
          return 'Fri';
      case 6:
          return 'Sat';
      case 7:
          return 'Sun';
      default :
        return '';
    }
  }
  //get the date for the start of the week
  DateTime startOfWeekdate(){
    DateTime? startofweek;

    // get todays date
    DateTime today = DateTime.now();

    for(int i=0;i<7;i++){
      if(getDayName(today.subtract(Duration(days: i)))=='Sun'){

        startofweek =today.subtract(Duration(days: i));
      }
    }
    return startofweek!;
  }
  // calculate dailyexpense

Map<String,double> calculateDailyExpense(){
    Map<String,double> dailyExpenseSummary ={

    };
    for(var expense in overallList){
      String date = convertDayTimeToString(expense.datetime);
      double amount =double.parse(expense.amount);

      if(dailyExpenseSummary.containsKey(date)){
        double curr = dailyExpenseSummary[date]!;
        curr+=amount;
        dailyExpenseSummary[date]=curr;
      }
      else{
        dailyExpenseSummary.addAll({date:amount});
      }
    }
    return dailyExpenseSummary;
}

}