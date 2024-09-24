import 'package:bills_app/providers/exports.dart';
import 'package:bills_app/providers/import_owner.dart';
import 'package:bills_app/providers/imports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';
import '../providers/export_owner.dart';

Future<void> deleteAlert(
  BuildContext context,
  String id,
  String content,
  String ownerid,
  int opration,
) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text(
          "Are You Sure!!",
          style: TextStyle(color: Colors.red),
        ),
        icon: Icon(
          Icons.sd_card_alert_outlined,
          color: Theme.of(context).errorColor,
          size: 35,
        ),
        content: Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.cancel_outlined),
                label: const Text("Cancel"),
              ),
              SizedBox(width: 10),
              OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Theme.of(context).accentColor),
                  ),
                  onPressed: () async {
                    if (opration == 0) {
                      exportowners.removeWhere((onr) => onr.id == id);
                      await Provider.of<ExOwner>(context, listen: false)
                          .deleteImpOnr(id);
                    }
                    if (opration == 1) {
                      importowners.removeWhere((onr) => onr.id == id);
                      await Provider.of<ImpOwner>(context, listen: false)
                          .deleteImpOnr(id);
                    }
                    if (opration == 2) {
                      imports.removeWhere((onr) => onr.id == id);
                      await Provider.of<Import>(context, listen: false)
                          .deleteimp(id, ownerid);
                    }
                    if (opration == 3) {
                      exports.removeWhere((onr) => onr.id == id);
                      await Provider.of<Export>(context, listen: false)
                          .deleteexp(id, ownerid);
                    }
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("I'm Sure"))
            ],
          )
        ]),
  );
}
