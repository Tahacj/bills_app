import 'providers/exports.dart';
import 'providers/export_owner.dart';
import 'providers/import_owner.dart';
import 'providers/imports.dart';

List<Imports> imports = [
  Imports(
    id: "1",
    amount: 23.6,
    title: "imptitle1",
    discription: "discription1",
    dateTime: DateTime.now().subtract(
      Duration(days: 5),
    ),
    owner: "itap",
  ),
  Imports(
    id: "2",
    amount: 84.1,
    title: "imptitle2",
    discription: "discription2",
    dateTime: DateTime.now().subtract(Duration(days: 3)),
    owner: "olompiyat",
  )
];

List<ImportOwner> importowners = [
  const ImportOwner(
    id: "1",
    title: "itap",
  ),
  const ImportOwner(
    id: "2",
    title: "olompiyat",
  )
];

List<Exports> exports = [
  Exports(
    id: "1",
    amount: 23.6,
    title: "exptitle1",
    discription: "discription1",
    dateTime: DateTime.now().subtract(
      Duration(days: 5),
    ),
    owner: "hamhut",
  ),
  Exports(
    id: "2",
    amount: 84.1,
    title: "exptitle2",
    discription: "discription2",
    dateTime: DateTime.now().subtract(Duration(days: 3)),
    owner: "ahmed",
  )
];

List<ExportOwner> exportowners = [
  const ExportOwner(
    id: "1",
    title: "hamhut",
  ),
  const ExportOwner(
    id: "2",
    title: "ahmed",
  ),
];
