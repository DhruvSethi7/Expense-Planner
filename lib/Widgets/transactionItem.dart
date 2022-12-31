import 'dart:math';

import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionItemu extends StatefulWidget {
  const TransactionItemu({
    @required this.transaction,
    @required this.delete,
  });
  final Transaction transaction;
  final Function delete;

  @override
  State<TransactionItemu> createState() => _TransactionItemuState();
}

class _TransactionItemuState extends State<TransactionItemu> {
  Color bgColor;
  @override
  void initState() {
    // TODO: implement initState
    List<Color>colorsList=[Colors.red,Colors.blue,Colors.yellow,Colors.orange];
    bgColor=colorsList[Random().nextInt(4)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
     child: ListTile(
       leading: CircleAvatar(
         backgroundColor: bgColor,
         radius: 30,
         child: Padding(
           padding: EdgeInsets.all(6),
           child: FittedBox(
             child: Text(
               '₹${widget.transaction.amount}',
             ),
           ),
         ),
       ),
       title: Text(
         widget.transaction.title,
         style: TextStyle(
           fontFamily: 'OpenSans',
         ),
       ),
       subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
       trailing: MediaQuery.of(context).size.width>600?FlatButton.icon(
         onPressed:(){
           widget.delete(widget.transaction);
         }, icon: Icon(Icons.delete,color: Theme.of(context).errorColor), label:Text('Delete',style: TextStyle(color: Theme.of(context).errorColor),))
       :IconButton(onPressed: (){widget.delete(widget.transaction);},icon: Icon(Icons.delete,),color: Theme.of(context).errorColor,
     ),
              ),
            );
  }
}