import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/transaction.dart';
import './transactionItem.dart';
class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete;
  TransactionsList(this.transactions,this.delete);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: transactions.isEmpty
          ? Container(
              height: 300,
              child: Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: TextStyle(fontFamily: 'OpenSans'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset('assets/Images/waiting.png'),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index)=>TransactionItemu(transaction: transactions[index],delete: delete,),
             itemCount: transactions.length,
    )
    );
  }
}

