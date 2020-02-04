import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double totalAmount;

  ChartBar({this.label, this.amount, this.totalAmount});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constrains){
      return Container(
      child: Column(
        children: <Widget>[
          Container(height: 10, child: FittedBox(child: Text('\$ ${amount.toStringAsFixed(0)} '))),
          SizedBox(
            height: constrains.maxHeight * .05,
          ),
          Container(
            height: constrains.maxHeight *.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(    
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: totalAmount,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * .05,
          ),
          Container(
            height: constrains.maxHeight *.15,
            child: FittedBox(child: Text(label)))
        ],
      ),
    );
    },);
    
  }
}
