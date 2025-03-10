import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snap_locator/database/utils/db_utils.dart';

import '../tables/table_geo_data.dart';

part 'db_service.g.dart';

@DriftDatabase(tables: [GeoData])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => dbSchemaVersion;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: databaseName,
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),

      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
