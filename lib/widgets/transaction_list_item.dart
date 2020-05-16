import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem(
      {Key key, @required this.transaction, @required this.deleteTransaction})
      : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
                child: Text('\$${transaction.amount.toStringAsFixed(2)}')),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(transaction.date),
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        trailing: mediaQuery.size.width > 360
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                label: const Text('Delete'),
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteTransaction(context, transaction);
                },
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  deleteTransaction(context, transaction);
                },
              ),
      ),
    );
  }
}
