import 'dart:math';

import 'package:bills_app/providers/imports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/imports_screen.dart';
import '../providers/import_owner.dart';

class ImportOwnerItem extends StatefulWidget {
  const ImportOwnerItem({
    Key? key,
    required this.importowner,
    required this.deleteowner,
  }) : super(key: key);

  final ImportOwner importowner;
  final Function deleteowner;

  @override
  State<ImportOwnerItem> createState() => _ImportItemState();
}

class _ImportItemState extends State<ImportOwnerItem> {
  late Color _bgColor;
  late Color _avColor;
  void selectImportOwner(BuildContext context, String title, String id) {
    setState(() {
      Navigator.of(context).pushNamed(
        ImportsScreen.routeName,
        arguments: {
          "title": title,
          "id": id,
        },
      );
    });
  }

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
    final imports = Provider.of<Import>(context);
    imports.imps.forEach((element) {
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
      margin: EdgeInsets.all(15),
      child: ListTile(
        onTap: () => selectImportOwner(
            context, widget.importowner.title, widget.importowner.id),
        leading: CircleAvatar(
          backgroundColor: _avColor,
          radius: 25,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
                child: Text(
              " ${total} ₺",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            )),
          ),
        ),
        title: Text(
          widget.importowner.title,
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
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
          onPressed: () => widget.deleteowner(widget.importowner.id),
        ),
      ),
    );
  }
}
