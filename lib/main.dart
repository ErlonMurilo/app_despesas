import 'dart:math';

import 'package:app_despesas/components/chart.dart';
import 'package:app_despesas/components/transaction_form.dart';
import 'package:app_despesas/components/transaction_list.dart';

import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main(List<String> args) {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const MyHomePage(),
        theme: ThemeData(
          useMaterial3: false,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.w700),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            primary: Colors.green,
            secondary: Colors.amber,
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: Random().nextDouble().toString(),
        title: 'Cocada',
        value: 9,
        date: DateTime.now().subtract(Duration(days: 20)),
      ),
      Transaction(
        id: Random().nextDouble().toString(),
        title: 'Cocada',
        value: 9,
        date: DateTime.now().subtract(Duration(days: 5)),
      ),
      Transaction(
        id: Random().nextDouble().toString(),
        title: 'Cocada',
        value: 9,
        date: DateTime.now().subtract(Duration(days: 7)),
      ),
  ];

  _addTransaction(String title, double value) {
    setState(() {
      _transactions.add(Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now(),
      ));
    });

    Navigator.of(context).pop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Despesas Pessoais',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Chart(_transactions),
          TransactionList(_transactions),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return TransactionForm(_addTransaction);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
