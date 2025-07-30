import 'package:app_despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        : ListView.builder(
            itemCount: widget.transactions.length,
            itemBuilder: (context, index) {
              final tr = widget.transactions[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                elevation: 5,
                child: ListTile(
                  titleTextStyle: Theme.of(context).textTheme.titleLarge,
                  subtitleTextStyle: const TextStyle(color: Colors.grey),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          'R\$ ${tr.value.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(tr.title),
                  subtitle: Text(
                    DateFormat('dd MMM yyyy').format(tr.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? TextButton.icon(
                          onPressed: () {
                            widget._onRemove(tr.id);
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text('Exluir'),
                          style: const ButtonStyle(
                            foregroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 255, 0, 0),
                            ),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            widget._onRemove(tr.id);
                          },
                        ),
                ),
              );
            },
          );
  }
}
