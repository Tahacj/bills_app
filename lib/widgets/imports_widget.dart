import 'package:bills_app/screens/imports_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/imports.dart';
import '../widgets/import_item.dart';

class ImportsWidget extends StatefulWidget {
  final String owner;
  final Function deleteImp;

  ImportsWidget(this.owner, this.deleteImp);

  @override
  State<ImportsWidget> createState() => _ImportsWidgetState();
}

class _ImportsWidgetState extends State<ImportsWidget> {
  @override
  void initState() {
    Provider.of<Import>(context, listen: false).findByOwner(widget.owner);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Import>(context);

    return Container(
      child: data.imps.length == 0
          ? const Center(
              child: Text("no imports"),
            )
          : ListView.builder(
              itemBuilder: (context, index) => ChangeNotifierProvider<Import>(
                  create: (context) => data,
                  child: ImportItem(
                    import1: data.imps[index],
                    deleteImp: widget.deleteImp,
                  )),
              itemCount: data.imps.length,
            ),
    );
  }
}
