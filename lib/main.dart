import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:expense_planner/Widgets/chart.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transactions_list.dart';
import './Models/transaction.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Planner',
        home: MyHomePage(),
        theme: ThemeData(
            primarySwatch: Colors.green,
            // errorColor: Colors.red,
            accentColor: Colors.yellow,
            appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                    ),
            textTheme:ThemeData.light().textTheme.copyWith(
              button:TextStyle(color: Colors.white)
            )    
                    )
                    );
  }
}
class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];
  bool _showChart=false;
 
  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  void _addNewTransaction(String txTitle, int txAmount,DateTime date_recieved) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: date_recieved,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }
  
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: newTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
  void delete(Transaction transaction){
    setState(() {
      _userTransactions.remove(transaction);
    });
  }
  bool platformIsIos(){
    if(Platform.isIOS)return true;
    else return false;
  }
  Widget applebar(){
    return CupertinoNavigationBar(
      middle: Text('Personal Expense'),
      );
  }
  Widget androidbar(){
    return  AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    bool isLandscape=(MediaQuery.of(context).orientation)==Orientation.landscape;
    final PreferredSizeWidget appbar=!platformIsIos()?androidbar():applebar();
      final chart=Container(
              height: (MediaQuery.of(context).size.height-appbar.preferredSize.height
              -MediaQuery.of(context).padding.top) * 0.25,
              child: Chart(_recentTransactions));
      final list=Container(
              height: (MediaQuery.of(context).size.height-appbar.preferredSize.height
              -MediaQuery.of(context).padding.top) * 0.75,
              child: TransactionsList(_userTransactions,delete)) ;        
    return  Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape)
            Container(
              height: (MediaQuery.of(context).size.height-appbar.preferredSize.height
              -MediaQuery.of(context).padding.top) * 0.2,
              child: Row(mainAxisAlignment: MainAxisAlignment.center
              ,children: [Text('Show Chart'),
              Switch(value:_showChart, onChanged: (val){
                setState(() {
                  _showChart=val;
                });
              },
              )
              ],),
            ),
            if(isLandscape)
            _showChart?Container(
              height: (MediaQuery.of(context).size.height-appbar.preferredSize.height
              -MediaQuery.of(context).padding.top) * 0.8,
              child: Chart(_recentTransactions))
            :Container(
              height: (MediaQuery.of(context).size.height-appbar.preferredSize.height
              -MediaQuery.of(context).padding.top) * 0.8, 
              child: TransactionsList(_userTransactions,delete)),
            if(!isLandscape)
            chart,
            list  
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
