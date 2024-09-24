import 'package:bills_app/providers/imports.dart';
import 'package:bills_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Imports> resentImps;

  Chart(this.resentImps);

  List<Map<String, dynamic>> get groupimpval {
    return List.generate(6, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (int i = 0; i < resentImps.length; i++) {
        if (resentImps[i].dateTime.day == weekDay.day &&
            resentImps[i].dateTime.month == weekDay.month &&
            resentImps[i].dateTime.year == weekDay.year) {
          totalSum += resentImps[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  double get totalmaxspending {
    return groupimpval.fold(0.0, (previousValue, element) {
      return previousValue += element["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 7,
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupimpval.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  e["day"],
                  e["amount"],
                  totalmaxspending == 0.0
                      ? 0.0
                      : (e["amount"] as double) / totalmaxspending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
