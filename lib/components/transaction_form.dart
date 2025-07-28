import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  _onSubmit() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectDate);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                  child: TextField(
                    onSubmitted: (value) {
                      _onSubmit();
                    },
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                  child: TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (value) {
                      _onSubmit();
                    },
                    controller: valueController,
                    decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                              'Data selecionada: ${DateFormat('dd/MM/yyyy').format(_selectDate)}')),
                      TextButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            ).then((pickedDate) {
                              setState(() {
                                pickedDate == null
                                    ? null
                                    : _selectDate = pickedDate;
                              });
                            });
                          },
                          child: Text(
                            'Selecionar data',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _onSubmit();
                        },
                        child: const Text('Nova transação',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
