
import 'package:expensetracker/components/exepense_summary.dart';
import 'package:expensetracker/components/expense_tile.dart';
import 'package:expensetracker/data/expense_data.dart';
import 'package:expensetracker/models/expense_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  // void initState() {
  //   // TODO: implement initState
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  //   super.initState();
  // }
  //text controler
  final expenseName =TextEditingController();
  final expenseAmountRupay =TextEditingController();
  final expenseAmountPaise =TextEditingController();


  void AddNewExpense(){
  showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text("Add new Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //name
            TextField(
              controller: expenseName,
              decoration: InputDecoration(
                hintText: "Expense",
              ),
            ),

            // amount
            Row(
              children: [
                //rupay
                Expanded(
                  child: TextField(
                    controller: expenseAmountRupay,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Rupee",
                    ),
                  ),
                ),
                //paise
                Expanded(
                  child: TextField(
                    controller: expenseAmountPaise,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "paise",
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          //save button
          MaterialButton(onPressed: save,child: Text("Save"),),

          // cancle button
          MaterialButton(onPressed: cancle,child: Text("Cancle"),),
        ],

      ),
  );
  }
  //delete the expense
  void deleteesxpense(Expense_items expense){
    Provider.of<Expense_data>(context,listen: false).deleteexpense(expense);
  }
  void save(){
    // add paise and rupay
    if( expenseName.text.isNotEmpty &&
        expenseAmountRupay.text.isNotEmpty &&
        expenseAmountPaise.text.isNotEmpty){
      String amount = '${expenseAmountRupay.text}.${expenseAmountPaise.text}';

      Expense_items newepense = new Expense_items(
          amount: amount, name: expenseName.text, datetime: DateTime.now());
      Provider.of<Expense_data>(context, listen: false).addexpense(newepense);
    }

    Navigator.pop(context);
    clear();
  }
  void cancle(){
    Navigator.pop(context);
    clear();
  }
  void clear(){
    expenseName.clear();
    expenseAmountPaise.clear();
    expenseAmountRupay.clear();
  }

  void inState(){
    super.initState();
    
    Provider.of<Expense_data>(context,listen: false).preparedata();
  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<Expense_data>(
        builder: (context,value,child)=>Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: AddNewExpense,
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
          body: ListView(
            padding:EdgeInsets.only(top: 50),
            children: [
              //weekely summary
              expense_summary(startofweek: value.startOfWeekdate()),

              const SizedBox(height: 10,),
              //expense list
              ListView.builder(

               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemCount: value.overallList.length,
                itemBuilder: (context,index)=>expenseTile(
                   name: value.overallList[index].name,
                   amount: value.overallList[index].amount,
                   dateTime: value.overallList[index].datetime,
                  deleteTapped: (p0)=>deleteesxpense(value.overallList[index]),
              ),
              ),
            ],
          ),
          ),
        );
  }
}
