import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exports.dart';
import 'export_item.dart';

class ExportsWidget extends StatefulWidget {
  final String Owner;
  final Function deleteExp;

  ExportsWidget(this.Owner, this.deleteExp);

  @override
  State<ExportsWidget> createState() => _ExportsWidgetState();
}

class _ExportsWidgetState extends State<ExportsWidget> {
  @override
  void initState() {
    Provider.of<Export>(context, listen: false).findByOwner(widget.Owner);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Export>(context);
    return Container(
      child: data.exprts.length == 0
          ? const Center(
              child: Text("no imports"),
            )
          : ListView.builder(
              itemBuilder: (context, index) => ChangeNotifierProvider(
                  create: (context) => data,
                  child: ExportItem(
                    export: data.exprts[index],
                    deleteExp: widget.deleteExp,
                  )),
              itemCount: data.exprts.length,
            ),
    );
  }
}
