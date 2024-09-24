import 'dart:convert';

import 'package:bills_app/dummy_data.dart';
import 'package:bills_app/providers/import_owner.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Imports {
  final String id;
  final double amount;
  final String title;
  final String discription;
  final DateTime dateTime;
  final String owner;

  const Imports({
    required this.id,
    required this.amount,
    required this.title,
    required this.discription,
    required this.dateTime,
    required this.owner,
  });
}

class Import with ChangeNotifier {
  List<Imports> _imps = [];
  List<Imports> get imps {
    return [..._imps];
  }

  int get itemCount {
    return _imps.length;
  }

  Future<void> findByOwner(String owner) async {
    //final filterString = 'orderBy="owner"&equalTo="$owner"';
    _imps = [];
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/import-owners/$owner/imports.json");
    try {
      var response = await http.get(url);
      if (response.body == "null") {
        return;
      }
      var exractedData = json.decode(response.body) as Map<String, dynamic>;
      //print("response : ${json.decode(response.body)}");
      exractedData.forEach((impId, impData) {
        _imps.add(Imports(
          id: impId,
          amount: impData["amount"],
          title: impData["title"],
          discription: impData["discription"],
          dateTime: DateTime.parse(impData["date"]),
          owner: impData["owner"],
        ));
      });

      notifyListeners();
      // return _imps;
    } catch (err) {
      print("here error : $err");
      throw err;
    }
  }

  Future<void> addimp(Imports import, String ownerId) async {
    final date = import.dateTime;
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/import-owners/$ownerId/imports.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "title": import.title,
            "discription": import.discription,
            "amount": import.amount,
            "date": date.toIso8601String(),
            "owner": import.owner,
          },
        ),
      );
      final newExport = Imports(
        id: json.decode(response.body)["name"],
        amount: import.amount,
        title: import.title,
        discription: import.discription,
        dateTime: import.dateTime,
        owner: import.owner,
      );
      _imps.add(newExport);
      imports = _imps;
      notifyListeners();
    } catch (err) {
      print("the err is : $err");
      throw err;
    }
  }

  Future<void> deleteimp(String id, String ownerId) async {
    final imp = _imps.firstWhere((imp) => imp.id == id);
    final owner = imp.owner;

    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/import-owners/$ownerId/imports/$id.json");
    final existingProductIndex =
        _imps.indexWhere((element) => element.id == id);
    Imports? existingProduct = _imps[existingProductIndex];
    _imps.removeAt(existingProductIndex);
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _imps.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw const Text("Could not delete product.");
    }
    existingProduct = null;

    _imps.removeWhere(
      (imp) => imp.id == id,
    );

    notifyListeners();
  }
}
