import 'package:expense_planner/Widgets/chart_bars.dart';

import '/Models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String,Object>> get groupedTransactionsValues{
    return List.generate(7, (index){
      final weekDay=DateTime.now().subtract(Duration(days: index));  
      int totalAmount=0;
      for(int i=0;i<recentTransactions.length;i++){
        if(recentTransactions[i].date.day==weekDay.day){
          totalAmount+=recentTransactions[i].amount;
        }
      }
      return {'day':DateFormat.E().format(weekDay).substring(0,3),'amount':totalAmount};
    }).reversed.toList();
  }
  int get totalSpending{
    return groupedTransactionsValues.fold(0, (sum,item) => sum+(item['amount']as int));
  }
  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: 
            groupedTransactionsValues.map((item){
              return Flexible(fit:FlexFit.tight,
              child: Chart_Bars(label:item['day'] ,amount: item['amount'],percentoftotal: totalSpending==0?0.0:(((item['amount'] as int)/totalSpending) as double)));
            }).toList(),
        ),
      ),
    );
  }
}