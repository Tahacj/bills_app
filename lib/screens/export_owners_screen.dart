import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/helpers/alert_dialog.dart';
import '../widgets/add_owner.dart';
import '../providers/export_owner.dart';
import '../widgets/export_owners_widget.dart';

class ExportOwnersScreen extends StatefulWidget {
  static const routeName = "/exportsOwner";
  const ExportOwnersScreen({Key? key}) : super(key: key);

  @override
  State<ExportOwnersScreen> createState() => _ExportOwnersScreenState();
}

class _ExportOwnersScreenState extends State<ExportOwnersScreen> {
  var _isInit = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      _isLoading = true;
      await Provider.of<ExOwner>(context).findexponrs().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  void _startAddNewTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AddOwner(
              currentpage: 1,
            ),
          );
        });
  }

  Future<void> _deleteowner(String id) async {
    final content =
        "this opration will delete the export owner and the export transactions that belong to him !!!!!! ";
    setState(() {
      deleteAlert(context, id, content, "", 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final medQry = MediaQuery.of(context);
    final listhight = (medQry.size.height - 150 - medQry.padding.top);

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: listhight,
                      child: ExportOwnersWidget(_deleteowner),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTx(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
