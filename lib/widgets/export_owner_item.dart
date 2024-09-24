import 'dart:math';

import 'package:bills_app/providers/exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/export_owner.dart';
import '../screens/exports_screen.dart';

class ExportOwnerItem extends StatefulWidget {
  const ExportOwnerItem(
      {Key? key, required this.exportowner, required this.deleteExpOwner})
      : super(key: key);

  final ExportOwner exportowner;
  final Function deleteExpOwner;

  @override
  State<ExportOwnerItem> createState() => _ExportOwnerItemState();
}

class _ExportOwnerItemState extends State<ExportOwnerItem> {
  void selectExportOwner(BuildContext context, String title, String id) {
    Navigator.of(context).pushNamed(
      ExportsScreen.routeName,
      arguments: {
        "title": title,
        "id": id,
      },
    );
  }

  late Color _bgColor;
  late Color _avColor;

  @override
  void initState() {
    const availableColors = [
      Color.fromARGB(255, 18, 36, 63),
      Color.fromARGB(255, 244, 152, 90),
      Color.fromARGB(255, 184, 233, 212),
      Color.fromARGB(255, 53, 81, 138),
      Color.fromARGB(255, 240, 205, 151),
      Color.fromARGB(255, 220, 241, 128),
      Colors.blueGrey,
    ];
    const availableColors1 = [
      Color.fromARGB(255, 237, 115, 168),
      Color.fromARGB(255, 60, 140, 222),
      Colors.amber,
      // Colors.purple,
      // Colors.blue,
      // Colors.amberAccent,
      // Colors.blueGrey,
    ];
    _bgColor = availableColors[Random().nextInt(availableColors.length)];
    _avColor = availableColors1[Random().nextInt(availableColors1.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var total = 0.0;
    final export = Provider.of<Export>(context);
    export.exprts.forEach((element) {
      total += element.amount;
    });

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _bgColor.withOpacity(0.7),
            _bgColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.all(15),
      child: ListTile(
        onTap: () => selectExportOwner(
            context, widget.exportowner.title, widget.exportowner.id),
        leading: CircleAvatar(
          radius: 25,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text("$total ₺ "),
            ),
          ),
        ),
        title: Text(
          widget.exportowner.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        // subtitle: Text(
        //   DateFormat.yMEd().format(widget.importowner.dateTime),
        //   style: const TextStyle(
        //       color: Color.fromARGB(255, 66, 66, 66),
        //       fontWeight: FontWeight.w400),
        // ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
            size: 26,
          ),
          onPressed: () => widget.deleteExpOwner(widget.exportowner.id),
        ),
      ),
    );
  }
}
