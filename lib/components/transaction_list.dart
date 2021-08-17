import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDelete;

  TransactionList(this.transactions, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(children: [
              SizedBox(height: 20),
              Text('Nenhuma transação cadastrada',
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(height: 30),
              Container(
                height: constraints.maxHeight * .3,
                child: Image.asset(
                  './assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ]);
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
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
            },
          );
  }
}
