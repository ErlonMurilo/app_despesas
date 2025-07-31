import 'package:app_despesas/models/transaction.dart';
import 'package:flutter/material.dart';

import 'transaction_item.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function(String id) _onRemove;

  const TransactionList(this.transactions, this._onRemove, {super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(children: [
                Text(
                  'Nenhuma transação encontrada',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Image.asset(
                  'assets/images/waiting.png',
                  height: constraints.maxHeight * 0.8,
                )
              ]);
            },
          )
        : ListView(
            children: widget.transactions.map((tr) {
              return TransactionItem(
                key: ValueKey(tr.id),
                tr: tr,
                onRemove: widget._onRemove,
              );
            }).toList(),
          );

    // ListView.builder(
    //     itemCount: widget.transactions.length,
    //     itemBuilder: (context, index) {
    //       final tr = widget.transactions[index];
    //       return TransactionItem(
    //         key: ValueKey(tr.id),
    //         tr: tr,
    //         onRemove: widget._onRemove,
    //       );
    //     },
    //   );
  }
}
