import 'package:app_despesas/models/transaction.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
   MyHomePage({super.key});

  final _transactions = [Transaction(
    id: 't1', title: 'Novo Tênis de Corrida', value: 310.76, date: DateTime.now()
  ),
  Transaction(
    id: 't2', title: 'Conta de Luz', value: 211.30, date: DateTime.now()
  )];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'Despesas Pessoais',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              elevation: 5,
              color: Colors.blueAccent,
              child: Text('Gráfico'),
            ),
            Column(
              children: _transactions.map((tr){
                return Card(
                  child: Text(tr.title),
                );
              }).toList(),
            )
          ],
        ));
  }
}
