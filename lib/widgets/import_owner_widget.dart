import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/import_owner.dart';
import 'import_owner_item.dart';

class ImportOwnersWidget extends StatelessWidget {
  final Function deleteowner;

  ImportOwnersWidget(this.deleteowner);

  @override
  Widget build(BuildContext context) {
    final impowners = Provider.of<ImpOwner>(context, listen: false);
    return Container(
      child: impowners.imponrs.length == 0
          ? const Center(
              child: Text("no import owners"),
            )
          : ListView.builder(
              itemBuilder: (context, index) => ChangeNotifierProvider(
                create: (context) => impowners,
                child: ImportOwnerItem(
                  importowner: impowners.imponrs[index],
                  deleteowner: deleteowner,
                  key: ValueKey(impowners.imponrs[index].id),
                ),
              ),
              itemCount: impowners.imponrs.length,
            ),
    );
  }
}
