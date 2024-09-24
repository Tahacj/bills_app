import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExportOwner {
  final String id;
  final String title;

  const ExportOwner({
    required this.id,
    required this.title,
  });
}

class ExOwner with ChangeNotifier {
  List<ExportOwner> _exOnrs = [];
  List<ExportOwner> get exOnrs {
    return [..._exOnrs];
  }

  int get itemCount {
    return _exOnrs.length;
  }

  Future<void> findexponrs() async {
    _exOnrs = [];
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/export-owners.json");

    try {
      var response = await http.get(url);
      if (response.body == "null") {
        return;
      }
      var exractedData = json.decode(response.body) as Map<String, dynamic>;
      // if (_imponrs.length > exractedData.length) {
      //   _imponrs = [];
      //   // return;
      // }
      print("response : ${json.decode(response.body)}");
      exractedData.forEach((exponrId, exponrData) {
        _exOnrs.add(ExportOwner(
          id: exponrId,
          title: exponrData["title"],
        ));
      });
      notifyListeners();
      // return _imps;
    } catch (err) {
      print("here error : $err");
      throw err;
    }
  }

  Future<void> addExpOnr(ExportOwner exportOwner) async {
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/export-owners.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "title": exportOwner.title,
          },
        ),
      );
      final newImpOnr = ExportOwner(
        id: json.decode(response.body)["name"],
        title: exportOwner.title,
      );
      _exOnrs.add(newImpOnr);

      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> deleteImpOnr(String id) async {
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/export-owners/$id.json");
    final existingProductIndex =
        _exOnrs.indexWhere((element) => element.id == id);
    ExportOwner? existingProduct = _exOnrs[existingProductIndex];
    _exOnrs.removeAt(existingProductIndex);
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _exOnrs.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw const Text("Could not delete product.");
    }
    _exOnrs.removeWhere(
      (onr) => onr.id == id,
    );

    notifyListeners();
  }
}
