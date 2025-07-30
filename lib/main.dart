import 'dart:io';
import 'dart:math';

import 'package:app_despesas/components/chart.dart';
import 'package:app_despesas/components/transaction_form.dart';
import 'package:app_despesas/components/transaction_list.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'models/transaction.dart';

void main(List<String> args) {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("pt", "BR")
        ],
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
        theme: ThemeData(
          useMaterial3: false,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
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
            primary: Colors.purple,
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
      date: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Coca',
      value: 9,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Feijão',
      value: 9,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Refri Dight',
      value: 100,
      date: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Lua',
      value: 9000,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Cinema',
      value: 25,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  bool _showChart = false;

  _addTransaction(String title, double value, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date,
      ));
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  _openTransactionFormModal() {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isAndroid
        ? AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              'Despesas Pessoais',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20 * MediaQuery.textScalerOf(context).scale(1)),
            ),
            actions: [
              if (isLandscape)
                IconButton(
                    onPressed: () {
                      setState(() {
                        _showChart = !_showChart;
                      });
                    },
                    icon: Icon(_showChart ? Icons.list : Icons.show_chart)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _openTransactionFormModal,
              )
            ],
          )
        : CupertinoNavigationBar(
            middle: Text(
              'Despesas Pessoais',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20 * MediaQuery.textScalerOf(context).scale(1)),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLandscape)
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _showChart = !_showChart;
                        });
                      },
                      icon: Icon(_showChart ? Icons.list : Icons.show_chart)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _openTransactionFormModal,
                )
              ],
            ),
          );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (!isLandscape || _showChart)
            SizedBox(
              height: availableHeight * (isLandscape ? 0.7 : 0.3),
              child: Chart(_transactions),
            ),
          if (!isLandscape || !_showChart)
            SizedBox(
              height: availableHeight * (isLandscape ? 1 : 0.7),
              child: TransactionList(_transactions, _removeTransaction),
            ),
        ]),
      ),
    );

    return Platform.isAndroid
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              onPressed: _openTransactionFormModal,
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          )
        : CupertinoPageScaffold(
            child: bodyPage,
          );
  }
}
