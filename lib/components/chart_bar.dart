import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double value;
  final double porcentagem;
  final String label;

  const ChartBar(
      {super.key,
      required this.label,
      required this.porcentagem,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
            child: FittedBox(child: Text('R\$ ${value.toStringAsFixed(2)}'))),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            color: const Color.fromRGBO(220, 220, 220, 1),
            borderRadius: BorderRadius.circular(5),
          ),
          width: 10,
          height: 60,
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: porcentagem,
            child: Container(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Text(label)
      ],
    );
  }
}
