import 'package:drift/drift.dart';

class GeoData extends Table {
  late final id = integer().autoIncrement()();
  late final title = text()();
  late final desc = text()();
  late final imgPath = text().nullable()();
  late final createdAt = dateTime().withDefault(currentDateAndTime)();
}
  