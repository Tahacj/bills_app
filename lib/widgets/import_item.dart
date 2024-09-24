import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/imports.dart';

class ImportItem extends StatefulWidget {
  const ImportItem({
    Key? key,
    required this.import1,
    required this.deleteImp,
  }) : super(key: key);

  final Imports import1;
  final Function deleteImp;

  @override
  State<ImportItem> createState() => _ImportItemState();
}

class _ImportItemState extends State<ImportItem> {
  @override
  Widget build(BuildContext context) {
    double amount = widget.import1.amount;
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
              child: Text("₺ $amount"),
            ),
          ),
        ),
        title: Text(
          widget.import1.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          DateFormat.yMEd().format(widget.import1.dateTime),
          style: const TextStyle(
              color: Color.fromARGB(255, 66, 66, 66),
              fontWeight: FontWeight.w400),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteImp(widget.import1.id),
        ),
      ),
    );
  }
}
