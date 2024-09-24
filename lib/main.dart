import 'package:bills_app/providers/export_owner.dart';
import 'package:bills_app/providers/exports.dart';
import 'package:bills_app/providers/import_owner.dart';
import 'package:bills_app/providers/imports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/imports_screen.dart';
import './screens/export_owners_screen.dart';
import './screens/import_owners_sceen.dart';
import './screens/tabs_screen.dart';
import './screens/exports_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExOwner(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImpOwner(),
        ),
        ChangeNotifierProvider(
          create: (context) => Export(),
        ),
        ChangeNotifierProvider(
          create: (context) => Import(),
        ),
      ],
      child: Consumer(
        builder: (context, value, _) => MaterialApp(
          title: 'Bills App',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.amber,
              canvasColor: const Color.fromARGB(255, 230, 230, 230),
              textTheme: ThemeData.light().textTheme.copyWith(
                    titleMedium: const TextStyle(
                        fontSize: 20,
                        //fontFamily: "RobotoCondensed-Bold",
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(20, 51, 51, 1)),
                    titleLarge: const TextStyle(
                        fontSize: 24,
                        //fontFamily: "Raleway",
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                    bodySmall: const TextStyle(
                        fontSize: 22,
                        //fontFamily: "Raleway",
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(20, 51, 51, 1)),
                  )),
          home: const ImportOwnersScreen(),
          routes: {
            // ProductDetailScreen.routeName: (context) => ProductDetailScreen(), // refrence
            ImportOwnersScreen.routeName: (context) =>
                const ImportOwnersScreen(),
            ExportOwnersScreen.routeName: (context) =>
                const ExportOwnersScreen(),
            ImportsScreen.routeName: (context) => const ImportsScreen(),
            ExportsScreen.routeName: (context) => const ExportsScreen(),
          },
        ),
      ),
    );
  }
}
