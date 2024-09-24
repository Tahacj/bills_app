import 'package:bills_app/helpers/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exports.dart';
import '../dummy_data.dart';
import '../widgets/add_import_export.dart';
import '../widgets/export_widget.dart';

class ExportsScreen extends StatefulWidget {
  static const routeName = "/export";

  const ExportsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ExportsScreen> createState() => _ExportsScreenState();
}

class _ExportsScreenState extends State<ExportsScreen> {
  void _addExport(BuildContext context, String ownerTitle, String id) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AddImportExport(
              currentpage: 1,
              ownertitle: ownerTitle,
              onerId: id,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final medQry = MediaQuery.of(context);
    final listhight = (medQry.size.height - 150 - medQry.padding.top);
    final owner =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final ownerTitle = owner["title"].toString();
    final ownerId = owner["id"].toString();

    final temp = Provider.of<Export>(context);
    var total = 0.0;
    temp.exprts.forEach((element) {
      total += element.amount;
    });

    Future<void> deleteExp(String id) async {
      final content = "the opration will delete this export!";
      setState(() {
        deleteAlert(context, id, content, ownerId, 3);
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
                "$total ₺",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: ExportsWidget(ownerId, deleteExp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addExport(context, ownerTitle, ownerId),
        child: Icon(Icons.add),
      ),
    );
  }
}
