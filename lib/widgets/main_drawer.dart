import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);
  Widget _draweritem(
      BuildContext context, IconData icon, String title, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      //onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: const Text(
              "Bills App",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.pink),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _draweritem(
            context,
            Icons.import_export,
            "Main",
            () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          _draweritem(
            context,
            Icons.settings,
            "Filters",
            () {
              // Navigator.of(context)
              //     .pushReplacementNamed(FiltersScreen.routName);
            },
          ),
          _draweritem(
            context,
            Icons.info_outline,
            "Info",
            () {
              //Navigator.of(context).pushReplacementNamed(InfoScreen.routName);
            },
          ),
        ],
      ),
    );
  }
}
