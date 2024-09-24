import 'package:bills_app/helpers/alert_dialog.dart';
import 'package:bills_app/widgets/add_import_export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/imports_widget.dart';
import '../providers/imports.dart';
import '../dummy_data.dart';

class ImportsScreen extends StatefulWidget {
  static const routeName = "/imports";

  const ImportsScreen({
    Key? key,
    // required this.total,
  }) : super(key: key);

  // final double total;

  @override
  State<ImportsScreen> createState() => _ImportsScreenState();
}

class _ImportsScreenState extends State<ImportsScreen> {
  void _addImport(BuildContext context, String ownerTitle, String ownerId) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AddImportExport(
              currentpage: 0,
              ownertitle: ownerTitle,
              onerId: ownerId,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final medQry = MediaQuery.of(context);
    // final listhight = (medQry.size.height - 150 - medQry.padding.top);
    final owner =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final ownerTitle = owner["title"].toString();
    final ownerId = owner["id"].toString();

    final temp = Provider.of<Import>(context);
    var total = 0.0;
    temp.imps.forEach((element) {
      total += element.amount;
    });

    Future<void> deleteImp(String id) async {
      final content = "this opration will delete this import ! ";
      setState(() {
        deleteAlert(context, id, content, ownerId, 2);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(ownerTitle),
        actions: [
          Center(
            child: Text(
              "TOTAL :",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
            elevation: 12,
            color: Colors.white60,
            child: Center(
              widthFactor: 1.2,
              child: Text(
                " $total ₺",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: ImportsWidget(ownerId, deleteImp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addImport(context, ownerTitle, ownerId),
        child: Icon(Icons.add),
      ),
    );
  }
}
