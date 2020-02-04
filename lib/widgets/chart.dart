import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions ;
  Chart(this.recentTransactions);
List<Map<String,Object>> get groupedTransactionValues{
  return List.generate(7, (index){
    final weekDay = DateTime.now().subtract(Duration(days: index));
    double totasSum=0.0;
    for(int i =0 ;i<recentTransactions.length;i++)
    {
      if(recentTransactions[i].date.day == weekDay.day && 
         recentTransactions[i].date.month == weekDay.month &&
         recentTransactions[i].date.year == weekDay.year
      )
      {
        totasSum += recentTransactions[i].amount;
      }
    }
    return {
      'day':DateFormat.E().format(weekDay),
      'amount':totasSum
    };
  }).reversed.toList();
}

double get spendings {
  return groupedTransactionValues.fold(0.0, (sum,item){
    return sum+=item['amount'] ;
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            ...groupedTransactionValues.map((tx){
              return Flexible
              (
                fit: FlexFit.tight,
                child: ChartBar(label: tx['day'],amount: tx['amount'],totalAmount: spendings == 0.0? 0.0 : (tx['amount'] as double)/spendings));
            } 
            ).toList()
          ],),
        ),
      ),
    );
  }
}