import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions) {
    print('Constructor Chart');
  }

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: 6 - index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        final DateTime elDate = recentTransactions[i].date;

        if (elDate.day == weekDay.day &&
            elDate.weekday == weekDay.weekday &&
            elDate.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      // print('day: ${DateFormat.E().format(weekDay)}, amount : $totalSum');

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get maxSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Chart build');
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionsValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['day'],
                    spendingAmount: data['amount'],
                    spendingPctOfTotal: maxSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / maxSpending,
                  ),
                );
              }).toList()),
        ),
      );
  }
}
