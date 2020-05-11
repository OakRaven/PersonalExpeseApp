import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _userTranasctions = [
    Transaction(
        id: '1',
        title: 'New headset',
        amount: 13.99,
        date: DateTime.parse('2020-04-25')),
    Transaction(
        id: '2',
        title: 'Google Play',
        amount: 14.00,
        date: DateTime.parse('2020-05-01')),
    Transaction(
        id: '3',
        title: 'Office 365',
        amount: 16.99,
        date: DateTime.parse('2020-05-01')),
    Transaction(
        id: '4',
        title: 'Netflix',
        amount: 12.99,
        date: DateTime.parse('2020-05-02')),
    Transaction(
        id: '5',
        title: 'Amazon Prime',
        amount: 11.00,
        date: DateTime.parse('2020-05-04')),
    Transaction(
        id: '5',
        title: 'Amazon Prime',
        amount: 25.00,
        date: DateTime.parse('2020-05-06')),
    Transaction(
        id: '5',
        title: 'Amazon Prime',
        amount: 11.00,
        date: DateTime.parse('2020-05-08')),
    Transaction(
        id: '6',
        title: 'Shudder',
        amount: 33.99,
        date: DateTime.parse('2020-05-08'))
  ];

  List<Transaction> get recentTransactions {
    return _userTranasctions.where((i) {
      return i.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction({String title, double amount, DateTime date}) {
    setState(() {
      _userTranasctions.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date));

      _userTranasctions.sort((b, a) => a.date.compareTo(b.date));
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  _MyHomePageState() {
    _userTranasctions.sort((b, a) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(recentTransactions),
            TransactionList(_userTranasctions),
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
