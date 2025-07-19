import 'package:app_despesas/components/chart_bar.dart';
import 'package:app_despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final List<Transaction> recentTransaction;

  const Chart(this.recentTransaction, {super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double value = 0;

      for (Transaction transation in widget.recentTransaction) {
        if (transation.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7)))) {
          if (DateFormat.E().format(transation.date) ==
              DateFormat.E().format(weekDay)) {
            value += transation.value;
          }
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'value': value};
    }).reversed.toList();
  }

  double _valorTotal(groupedTransactions){
    return groupedTransactions.fold(0, (sum, tr){
      return sum += (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    final listGrouped = groupedTransactions;

    return Card(
        elevation: 5,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(listGrouped.length, (index) {
                return 
                Flexible(
                  fit: FlexFit.tight,
                  child: 
                  ChartBar(
                      label: listGrouped[index]['day'].toString(),
                      porcentagem:
                          double.parse(listGrouped[index]['value'].toString()) /
                              _valorTotal(listGrouped),
                      value: double.parse(listGrouped[index]['value'].toString())),
                )
                ;
              })),
        ));
  }
}
