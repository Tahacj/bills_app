import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/exports.dart';

class ExportItem extends StatefulWidget {
  const ExportItem({Key? key, required this.export, required this.deleteExp})
      : super(key: key);

  final Exports export;
  final Function deleteExp;

  @override
  State<ExportItem> createState() => _ExportItemState();
}

class _ExportItemState extends State<ExportItem> {
  @override
  Widget build(BuildContext context) {
    double amount = widget.export.amount;
    return Card(
      elevation: 7,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      color: Colors.blueGrey.shade300,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: amount > 0 ? Colors.blue : Colors.amber,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text("₺ ${amount}"),
            ),
          ),
        ),
        title: Text(
          widget.export.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          DateFormat.yMEd().format(widget.export.dateTime),
          style: const TextStyle(
              color: Color.fromARGB(255, 66, 66, 66),
              fontWeight: FontWeight.w400),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteExp(widget.export.id),
        ),
      ),
    );
  }
}
