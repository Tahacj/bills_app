import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';
import '../providers/export_owner.dart';
import '../providers/import_owner.dart';
import '../screens/tabs_screen.dart';

class AddOwner extends StatefulWidget {
  const AddOwner({Key? key, required this.currentpage}) : super(key: key);

  final int currentpage;

  @override
  State<AddOwner> createState() => _AddOwnerState();
}

class _AddOwnerState extends State<AddOwner> {
  final titleController = TextEditingController();
  String title = "";
  var _editimpOwner = const ImportOwner(
    id: "",
    title: "",
  );
  var _editexpOwner = const ExportOwner(
    id: "",
    title: "",
  );

  Future<void> submitdata() async {
    if (title.isEmpty) {
      return;
    }
    if (widget.currentpage == 0) {
      _editimpOwner = ImportOwner(
        id: (importowners.length + 1).toString(),
        title: title,
      );
      await Provider.of<ImpOwner>(context, listen: false)
          .addImpOnr(_editimpOwner);
    } else {
      _editexpOwner = ExportOwner(
        id: (exportowners.length + 1).toString(),
        title: title,
      );
      await Provider.of<ExOwner>(context, listen: false)
          .addExpOnr(_editexpOwner);
    }
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => TabsScreen()),
    //   (Route<dynamic> route) => false,
    // );
    // Navigator.of(context).pushNamed("/");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: "Title"),
                  controller: titleController,
                  onSubmitted: (_) => submitdata(),
                  onChanged: (value) => title = value,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                    color: Colors.purple,
                  )),
                  onPressed: submitdata,
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
