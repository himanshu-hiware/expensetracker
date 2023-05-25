import 'package:expensetracker/BarGraph/individiual_bar.dart';

class BarData{
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
   BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
});

List<IndividiualBar> barData=[];

  //initaialize bardata
  void initializeBarData(){
     barData = [
       //sun
       IndividiualBar(x:0,y:sunAmount),
       //mon
       IndividiualBar(x:1,y:monAmount),
       //tue
       IndividiualBar(x:2,y:tueAmount),
       //wed
       IndividiualBar(x:3,y:wedAmount),
       //thur
       IndividiualBar(x:4,y:thurAmount),
       //fri
       IndividiualBar(x:5,y:friAmount),
       //sat
       IndividiualBar(x:6,y:satAmount),

     ];

  }
}
