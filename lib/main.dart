import 'package:expensetracker/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'data/expense_data.dart';

void main() async {

  //initaialize Hive database
  await Hive.initFlutter();

  // create Hive Box
  await Hive.openBox("expense_db");


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context)=> Expense_data(),
      builder:(context,child )=> const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

