import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    //Barras para cada dia da semana no grafico
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 20,
                child: Container(
                  height: constraints.maxHeight * .15,
                  child: FittedBox(
                      child: Text(value > 1000
                          ? '${(value / 1000).toStringAsFixed(2)} K'
                          : '${value.toStringAsFixed(2)}')),
                ),
              ),
              SizedBox(height: constraints.maxHeight * .05),
              Container(
                height: constraints.maxHeight * .6,
                width: 10,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          color: Color.fromRGBO(200, 200, 200, 1),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    FractionallySizedBox(
                        heightFactor: percentage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: constraints.maxHeight * .05),
              Container(
                  child: FittedBox(child: Text(label)),
                  height: constraints.maxHeight * .12),
            ]);
      },
    );
  }
}
