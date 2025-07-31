import 'dart:math';

import 'package:app_despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction tr;
  final Function(String id) onRemove;

  const TransactionItem({required this.tr, required this.onRemove, super.key});

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.amber,
    Colors.blueGrey,
    Colors.deepOrangeAccent,
    Colors.purple,
    Colors.teal,
  ];

  late Color selectColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    selectColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 5,
      child: ListTile(
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        subtitleTextStyle: const TextStyle(color: Colors.grey),
        leading: CircleAvatar(
          backgroundColor: selectColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                'R\$ ${widget.tr.value.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(widget.tr.title),
        subtitle: Text(
          DateFormat('dd MMM yyyy').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () {
                  widget.onRemove(widget.tr.id);
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
                  widget.onRemove(widget.tr.id);
                },
              ),
      ),
    );
  }
}
