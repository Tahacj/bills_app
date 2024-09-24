import 'dart:convert';

import 'package:bills_app/dummy_data.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ImportOwner {
  final String id;
  final String title;

  const ImportOwner({
    required this.id,
    required this.title,
  });
}

class ImpOwner with ChangeNotifier {
  List<ImportOwner> _imponrs = [];
  List<ImportOwner> get imponrs {
    //findimponrs();
    return [..._imponrs];
  }

  int get itemCount {
    return _imponrs.length;
  }

  Future<void> findimponrs() async {
    _imponrs = [];
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/import-owners.json");

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
      exractedData.forEach((imponrId, imponrData) {
        _imponrs.add(ImportOwner(
          id: imponrId,
          title: imponrData["title"],
        ));
      });
      notifyListeners();
      // return _imps;
    } catch (err) {
      print("here error : $err");
      throw err;
    }
  }

  Future<void> addImpOnr(ImportOwner importOwner) async {
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/import-owners.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "title": importOwner.title,
          },
        ),
      );
      final newImpOnr = ImportOwner(
        id: json.decode(response.body)["name"],
        title: importOwner.title,
      );
      _imponrs.add(newImpOnr);
      importowners.add(newImpOnr);
      notifyListeners();
    } catch (err) {
      print("the err is $err");
      throw err;
    }
  }

  Future<void> deleteImpOnr(String id) async {
    final url = Uri.parse(
        "https://bills-app-4480f-default-rtdb.firebaseio.com/import-owners/$id.json");
    final existingProductIndex =
        _imponrs.indexWhere((element) => element.id == id);
    ImportOwner? existingProduct = _imponrs[existingProductIndex];
    _imponrs.removeAt(existingProductIndex);
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _imponrs.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw const Text("Could not delete product.");
    }
    existingProduct = null;
    _imponrs.removeWhere(
      (onr) => onr.id == id,
    );
    notifyListeners();
  }
}
