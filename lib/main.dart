import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './components/transaction_form.dart';
import './components/transaction_list.dart';
import './models/transaction.dart';
import 'components/chart.dart';
import 'dart:math';
import 'dart:io';
import './components/adaptative_button.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHomePage(),
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.purple[700],
            fontFamily: 'Quicksand'));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  _addTransaction(String title, double value, DateTime time) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: time,
    );
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((e) => e.id == id);
    });
  }

  final List<Transaction> _transactions = [];
  bool _showGraph = false;
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7), //tudo o que for antes de 7 dias retorna falso
      ));
    }).toList();
  }

  Widget _getIconButton(IconData icon, void Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final listIcon = Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list;
    final graphIcon = Platform.isIOS ? CupertinoIcons.graph_square : Icons.bar_chart;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //Passando o AppBar para uma variavel para pegar o height para calcular a responsividade;
    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showGraph ? listIcon : graphIcon,
          () {
            setState(() {
              _showGraph = !_showGraph;
            });
          },
        ),
      _getIconButton(
        Icons.add,
        () {
          _openTransactionFormModal(context);
        },
      )
    ];
    final mediaQuery = MediaQuery.of(context);
    //
    final appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: actions,
    );
    //available Height = Altura total - altura da AppBar - barra de status superior
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Container(
            //     height: availableHeight * 0.1,
            //     child: Container(
            //       padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Text('Exibir Grafico'),
            //           Switch.adaptive(
            //             activeColor: Theme.of(context).accentColor,
            //             value: _showGraph,
            //             onChanged: (value) {
            //               setState(() {
            //                 _showGraph = value;
            //               });
            //             },
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            if (_showGraph || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 0.8 : 0.30),
                child: Chart(_recentTransactions),
              ),

            if (!_showGraph || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.6),
                child: TransactionList(_transactions, _deleteTransaction),
              ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyPage,
            navigationBar: CupertinoNavigationBar(
              middle: Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _openTransactionFormModal(context);
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
