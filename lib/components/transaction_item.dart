import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.tr,
    required this.onDelete,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String p1) onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('R\$${tr.value.toStringAsFixed(2)}'),
          )),
        ),
        title: Text(
          tr.title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        subtitle: Text(DateFormat('dd MMM yy').format(tr.date)),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => onDelete(tr.id),
                icon: Icon(Icons.delete),
                style: TextButton.styleFrom(
                    primary: Theme.of(context).errorColor,
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold)),
                label: Text("Remover"))
            : IconButton(
                color: Theme.of(context).errorColor,
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () => onDelete(tr.id)),
      ),
    );
  }
}
