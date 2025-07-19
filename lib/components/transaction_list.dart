import 'package:app_despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transactions.isEmpty
          ? Column(children: [
              Text(
                'Nenhuma transação encontrada',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Image.asset('assets/images/waiting.png', height: 200)
              
            ])
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tr = transactions[index];
                return Card(
                    child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary)),
                      child: Text('R\$ ${tr.value.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr.title,
                            style: Theme.of(context).textTheme.titleLarge
                            ),
                        Text(
                          DateFormat('dd MMM yyyy').format(tr.date),
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ));
              },
            ),
    );
  }
}
