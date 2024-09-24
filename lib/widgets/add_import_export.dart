import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';
import '../providers/exports.dart';
import '../providers/imports.dart';

class AddImportExport extends StatefulWidget {
  const AddImportExport(
      {Key? key,
      required this.currentpage,
      required this.ownertitle,
      required this.onerId})
      : super(key: key);

  final int currentpage;
  final String ownertitle;
  final String onerId;
  @override
  State<AddImportExport> createState() => _AddImportExportState();
}

class _AddImportExportState extends State<AddImportExport> {
  final titleController = TextEditingController();
  final discrptionController = TextEditingController();
  final amountController = TextEditingController();
  String discription = "";
  String title = "";
  double amount = -1;

  var _isloading = false;

  DateTime selectDate = DateTime.now();

  var _editimp = Imports(
    id: "",
    title: "",
    amount: 0.0,
    dateTime: DateTime.now(),
    discription: "",
    owner: "",
  );
  var _editexp = Exports(
    id: "",
    title: "",
    amount: 0.0,
    dateTime: DateTime.now(),
    discription: "",
    owner: "",
  );

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(0001),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selectDate = pickedDate;
      });
    });
  }

  Future<void> submitdata(bool type) async {
    //print(_editimp.id);
    print(type);
    if (title.isEmpty || amount < -1 || amount == -1) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.pink.shade100,
          title: const Text("An error ocurred!",
              style: TextStyle(
                color: Colors.black,
              )),
          content: const Text(
            "somthing went wrong! \n please make sure all the input fields are right",
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("okey"),
            )
          ],
        ),
      );
      return;
    }
    if (!type) {
      amount = -amount;
    }
    print(amount);
    setState(() {
      _isloading = true;
    });
    if (widget.currentpage == 0) {
      _editimp = Imports(
        id: _editimp.id,
        title: title,
        amount: amount,
        dateTime: selectDate,
        discription: discription,
        owner: widget.ownertitle,
      );
      try {
        await Provider.of<Import>(context, listen: false)
            .addimp(_editimp, widget.onerId);
      } catch (err) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.pink.shade100,
            title: const Text("An error ocurred!",
                style: TextStyle(
                  color: Colors.black,
                )),
            content: const Text(
              "somthing went wrong! \n please try again \nif it doesn't work please contect us ",
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("okey"),
              )
            ],
          ),
        );
      }
    } else {
      _editexp = Exports(
        id: _editexp.id,
        title: title,
        amount: amount,
        dateTime: selectDate,
        discription: discription,
        owner: widget.ownertitle,
      );
      try {
        await Provider.of<Export>(context, listen: false)
            .addexp(_editexp, widget.onerId);
      } catch (err) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.pink.shade100,
            title: const Text("An error ocurred!",
                style: TextStyle(
                  color: Colors.black,
                )),
            content: const Text(
              "somthing went wrong! \n please try again \nif it doesn't work please contect us ",
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("okey"),
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isloading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _isloading
          ? Center(child: CircularProgressIndicator())
          : Card(
              elevation: 10,
              child: Container(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                          // add title
                          decoration: const InputDecoration(labelText: "Title"),
                          controller: titleController,
                          onSubmitted: (_) => submitdata(true),
                          onChanged: (value) => title = value),
                      TextField(
                        // add discription
                        decoration:
                            const InputDecoration(labelText: "Discription"),
                        controller: discrptionController,
                        onSubmitted: (_) => submitdata(true),
                        onChanged: (value) => discription = value,
                      ),
                      TextFormField(
                        // add amount
                        decoration: const InputDecoration(labelText: "Amount"),
                        controller: amountController,
                        onFieldSubmitted: (_) => submitdata(true),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "you have to insert a price";
                          }
                          if (double.tryParse(value) == null) {
                            return "Please enter a valid number";
                          }
                          if (double.parse(value) <= 0) {
                            return "this number is too small";
                          }
                          return null;
                        },
                        onChanged: (newvalue) =>
                            amount = double.parse(newvalue),
                      ),
                      Container(
                        height: 70,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                  selectDate == null
                                      ? "no date chosen !   "
                                      : "picked Date : " +
                                          DateFormat.yMd().format(selectDate),
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                            ),
                            OutlinedButton(
                                onPressed: _presentDatePicker,
                                child: const Text(
                                  "Choose Date",
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                              width: 3,
                              color: Colors.purple,
                            )),
                            onPressed: () => submitdata(false),
                            child: const Text(
                              "bill",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                              width: 4,
                              color: Colors.cyan,
                            )),
                            onPressed: () => submitdata(true),
                            child: const Text(
                              "paiment",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
    );
  }
}
