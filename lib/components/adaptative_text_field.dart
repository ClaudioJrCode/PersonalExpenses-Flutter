import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final bool _decimalKeyboard;
  final Function _onSubmit;
  final TextEditingController _editingController;
  final String label;

  AdaptativeTextField(this._decimalKeyboard, this._onSubmit,
      this._editingController, this.label);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: _decimalKeyboard),
                controller: _editingController,
                onSubmitted: (_) => _onSubmit(),
                placeholder: label,
          )
        : TextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: _decimalKeyboard),
            controller: _editingController,
            onSubmitted: (_) => _onSubmit(),
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
