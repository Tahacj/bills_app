import 'dart:convert';

import 'package:bills_app/dummy_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Exports {
  final String id;
  final double amount;
  final String title;
  final String discription;
  final DateTime dateTime;
  final String owner;

  const Exports({
    required this.id,
    required this.amount,
    required this.title,
    required this.discription,
    required this.dateTime,
    required this.owner,
  });
}

class Export with ChangeNotifier {
  List<Exports> _exprts = [];
  List<Exports> get exprts {
    return [..._exprts];
  }

  int get itemCount {
    return _exprts.length;
  }

  Future<void> findByOwner(String owner) async {
    //final filterString = 'orderBy="owner"&equalTo="$owner"';
    _exprts = [];
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/export-owners/$owner/exports.json");
    try {
      var response = await http.get(url);
      if (response.body == "null") {
        return;
      }
      var exractedData = json.decode(response.body) as Map<String, dynamic>;
      //print("response : ${json.decode(response.body)}");
      exractedData.forEach((impId, impData) {
        _exprts.add(Exports(
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

  Future<void> addexp(Exports export, String ownerId) async {
    final date = export.dateTime;
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/export-owners/$ownerId/exports.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "title": export.title,
            "discription": export.discription,
            "amount": export.amount,
            "date": date.toIso8601String(),
            "owner": export.owner,
          },
        ),
      );

      final newExport = Exports(
        id: json.decode(response.body)["name"],
        amount: export.amount,
        title: export.title,
        discription: export.discription,
        dateTime: export.dateTime,
        owner: export.owner,
      );
      _exprts.add(newExport);
      exports = _exprts;
      notifyListeners();
    } catch (err) {
      print("the err is : $err");
      throw err;
    }
  }

  Future<void> deleteexp(String id, String ownerId) async {
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/export-owners/$ownerId/exports/$id.json");
    final existingProductIndex =
        _exprts.indexWhere((element) => element.id == id);
    Exports? existingProduct = _exprts[existingProductIndex];
    _exprts.removeAt(existingProductIndex);
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _exprts.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw const Text("Could not delete product.");
    }
    existingProduct = null;

    _exprts.removeWhere(
      (imp) => imp.id == id,
    );

    notifyListeners();
  }
}
