
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectedDate;
    void _presentDatePicker() {
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now()
          ).then((date){
            if(date==null) return;
            setState(() {
                          _selectedDate=date;
            });
          })
          ;
    }
  @override
  Widget build(BuildContext context) {


    void submit() {
      final titleEntered = titleController.text;
      if(amountController.text.isEmpty) return;
      final amoumtEntered = double.parse(amountController.text);
      if (titleEntered.isEmpty || amoumtEntered <= 0 || _selectedDate == null) {
        return;
      }

      widget.addTx(titleEntered, amoumtEntered,_selectedDate);

      Navigator.of(context).pop();
    }

    return Container(
      child: SingleChildScrollView(
              child: Card(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(
              top: 10,
              right:10,
              left:10,
              bottom: 10+ MediaQuery.of(context).viewInsets.bottom
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    onSubmitted: (_) => submit()),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  onSubmitted: (_) => submit(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text(_selectedDate ==null ?'No Date Selected' : DateFormat.yMd().format(_selectedDate))),
                      FlatButton(
                          onPressed:_presentDatePicker,
                          child: Text(
                            'Pick a date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          )),
                    ],
                  ),
                ),
                RaisedButton(
                    child: Text('Add Transaction'),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
