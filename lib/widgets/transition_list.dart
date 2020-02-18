import 'package:expenses_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/models/transaction.dart';

class TransitionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransitionList(@required this.transactions, @required this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('TransitionList build');
    return transactions.isEmpty
        ? LayoutBuilder(builder: (builder, constraints) {
            return Column(children: <Widget>[
              Text('No Transactions added yet!',
                  style: Theme.of(context).textTheme.title),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ]);
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                transaction: transactions[index],
                deleteTx: deleteTx
              );
            },
            itemCount: transactions.length,
          );
  }
}
