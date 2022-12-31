import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class newTransaction extends StatefulWidget {
  final Function addNewTx;
  newTransaction(this.addNewTx);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  DateTime date_picked;
  final titleInputController=TextEditingController();

  final amountInputController=TextEditingController();

  void submit(){
        final title=titleInputController.text;
        final amount=int.parse(amountInputController.text);
        if(title.isEmpty || amount<=0 ||date_picked==null){
          return;
        }
        widget.addNewTx(title,amount,date_picked);
        Navigator.of(context).pop();
  }
  void pick_clicked(){
    showDatePicker(context: context, initialDate:DateTime.now(), firstDate:DateTime(2019), lastDate:DateTime.now())
    .then((date){
      if(date==null){
        return;
      }
      setState(() {
        date_picked=date;
      });
    });
  } 
  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: titleInputController,
                      onSubmitted: (_)=>submit(),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Amount',
                      ),
                      keyboardType: TextInputType.number,
                      controller: amountInputController,
                      onSubmitted: (_)=>submit(),
                    ),
                    Container(
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(child: Text(date_picked==null?'No date':'picked_date:${DateFormat("d-M-y").format(date_picked)} ')),
                          FlatButton(onPressed: (){pick_clicked();}, child:Text('Pick date',style:TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor),))
                        ]
                      ),
                    ),
                    RaisedButton(
                      onPressed:submit,
                      child: Text(
                        'Add Transaction'
                      ),
                      textColor:Theme.of(context).textTheme.button.color,
                      color:Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            );
  }
}