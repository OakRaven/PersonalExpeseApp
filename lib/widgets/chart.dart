import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    var items = List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var dailyTotal = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          dailyTotal += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': dailyTotal
      };
    });

    return items.reversed.toList();
  }

  double get maxTransactionAmount {
    return recentTransactions.fold(0.0, (current, item) {
      return current + item.amount;
    });
  }

  Chart(this.recentTransactions);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues.map((item) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: item['day'],
                  spendingAmount: item['amount'],
                  spendingPctOfTotal: maxTransactionAmount == 0.0
                      ? 0.0
                      : (item['amount'] as double) / maxTransactionAmount,
                ),
              );
            }).toList()),
      ),
    );
  }
}
