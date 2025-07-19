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
        if (transation.date.isAfter(DateTime.now().subtract(const Duration(days: 7)))) {
          if (DateFormat.E().format(transation.date) ==
              DateFormat.E().format(weekDay)) {
            value += transation.value;
          }
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'value': value};
    });
  }

  @override
  Widget build(BuildContext context) {

    return Card(
        elevation: 5,
        margin: const EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(groupedTransactions.length, (index) {
              return Column(
                children: [
                  Text('${groupedTransactions[index]['value']}'),
                  Container(
                    color: Colors.blueAccent,
                    width: 30,
                    height: 100,
                  ),
                  Text('${groupedTransactions[index]['day']}')
                ],
              );
            })));
  }
}
