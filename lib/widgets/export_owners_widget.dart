import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/export_owner.dart';
import 'export_owner_item.dart';

class ExportOwnersWidget extends StatelessWidget {
  final Function deleteExpowner;

  ExportOwnersWidget(this.deleteExpowner);

  @override
  Widget build(BuildContext context) {
    final expowners = Provider.of<ExOwner>(context, listen: false);
    return Container(
      child: expowners.exOnrs.length == 0
          ? const Center(
              child: Text("no exports"),
            )
          : ListView.builder(
              itemBuilder: (context, index) => ChangeNotifierProvider(
                create: (context) => expowners,
                child: ExportOwnerItem(
                  exportowner: expowners.exOnrs[index],
                  deleteExpOwner: deleteExpowner,
                  key: ValueKey(expowners.exOnrs[index].id),
                ),
              ),
              itemCount: expowners.exOnrs.length,
            ),
    );
  }
}
