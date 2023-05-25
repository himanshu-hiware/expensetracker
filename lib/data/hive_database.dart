import 'package:expensetracker/models/expense_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class HiveDB{

  final  _mybox= Hive.box("expense_db");
  // write data

  void saveDate(List<Expense_items> allexpense){
    List<List<dynamic>> allExpenseFormated=[];

    for(var expense in allexpense){
      List<dynamic> Expenseformated=[
        expense.name,
        expense.amount,
        expense.datetime,
      ];
      allExpenseFormated.add(Expenseformated);
    }
    _mybox.put("ALL_EXPENSE", allExpenseFormated);
  }
  //read data
  List<Expense_items> readData(){

    List savedExpense = _mybox.get("ALL_EXPENSE")?? [];
    List<Expense_items> allexpense=[];

    for(int i=0;i<savedExpense.length;i++){
      String name = savedExpense[i][0];
      String amount = savedExpense[i][1];
      DateTime datetime = savedExpense[i][2];

      Expense_items expense = Expense_items(
        name: name,
        amount: amount,
        datetime: datetime,
      );
      // add it ot the list
      allexpense.add(expense);
    }

    return allexpense;
  }
}