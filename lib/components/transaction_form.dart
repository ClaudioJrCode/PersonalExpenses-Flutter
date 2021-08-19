import 'package:expenses/components/adaptative_button.dart';
import 'package:flutter/material.dart';

import 'adaptative_date_picker.dart';
import 'adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _textController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _textController.text;
    final value = double.tryParse(_valueController.text) ?? 0.00;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(children: <Widget>[
            AdaptativeTextField(
                false, _submitForm, _textController, "Descrição"),
            AdaptativeTextField(
                true, _submitForm, _valueController, "Valor (R\$)"),
            AdaptativeDatePicker(_selectedDate, (newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AdaptativeButton('Adicionar', _submitForm),
                // FloatingActionButton(
                //   //style: TextButton.styleFrom(primary: Colors.purple),
                //   child: Icon(Icons.check),
                //   onPressed: _submitForm,
                // ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
