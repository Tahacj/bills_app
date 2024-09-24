import 'package:bills_app/helpers/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';
import '../widgets/add_owner.dart';
import '../widgets/import_owner_widget.dart';
import '../providers/import_owner.dart';

class ImportOwnersScreen extends StatefulWidget {
  static const routeName = "/importowners";
  const ImportOwnersScreen({Key? key}) : super(key: key);

  @override
  State<ImportOwnersScreen> createState() => _ImportOwnersScreenState();
}

class _ImportOwnersScreenState extends State<ImportOwnersScreen> {
  var _isInit = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      _isLoading = true;
      await Provider.of<ImpOwner>(context).findimponrs().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  void _startAddNewTx(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: const AddOwner(
            currentpage: 0,
          ),
        );
      },
    );
  }

  Future<void> _deleteowner(String id) async {
    final content =
        "this opration will delete the import owner and the import transactions that belong to him !!!!!! ";
    setState(() {
      deleteAlert(context, id, content, "", 1);
    });
  }

  Widget build(BuildContext context) {
    final medQry = MediaQuery.of(context);
    final listhight = (medQry.size.height - 150 - medQry.padding.top);

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: listhight,
                      child: ImportOwnersWidget(_deleteowner),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTx(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
