import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  
  
  AdaptativeButton(
    this.label,
    this.onPressed,
  );
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(child: Text(label), onPressed: onPressed)
        : ElevatedButton(child: Text(label), onPressed: onPressed);
  }
}
