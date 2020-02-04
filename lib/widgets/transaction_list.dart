
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function rmTx;
  TransactionList({this.userTransactions,this.rmTx});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: userTransactions.isEmpty
            ? 
            LayoutBuilder(builder: (ctx,constrains){
              return             Column(
                children: <Widget>[
                  Text('No Data'),
                  SizedBox(
                    height: 29,
                  ),
                  Container(
                      height: constrains.maxHeight *.7,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            },)

            : ListView.builder(
                itemCount: userTransactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                              child:
                                  Text('\$${userTransactions[index].amount}')),
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        userTransactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(userTransactions[index].date)),
                          trailing: IconButton(icon: Icon(Icons.delete),onPressed:()=>rmTx(userTransactions[index].id),color: Theme.of(context).errorColor,),
                    ),
                  );
                },
                scrollDirection: Axis.vertical,
              ),
      ),
    );
  }
}
