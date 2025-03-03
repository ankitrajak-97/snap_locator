import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // Singleton pattern to ensure only one instance of DBHelper
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();

  static const String TABLE_NAME = 'geo_tagged_items';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_NAME = 'name';
  static const String COLUMN_DESC = 'description';
  static const String COLUMN_IMAGE_PATH = 'image_path';
  static const String COLUMN_LAT = 'latitude';
  static const String COLUMN_LNG = 'longitude';

  Database? _db;
  final String _dbName = 'geo_items.db';

  /// Get Database Instance
  Future<Database> getDB() async {
    _db ??= await _openDB();
    return _db!;
  }

  /// Open Database (Create if not exists)
  Future<Database> _openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, _dbName);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_NAME TEXT NOT NULL,
            $COLUMN_DESC TEXT NOT NULL,
            $COLUMN_IMAGE_PATH TEXT,
            $COLUMN_LAT REAL NOT NULL,
            $COLUMN_LNG REAL NOT NULL
          )
        ''');
      },
    );
  }

  /// Insert a New GeoTagged Item
  Future<bool> addItem({
    required String name,
    required String desc,
    String? imagePath,
    required double lat,
    required double lng,
  }) async {
    var db = await getDB();
    int rowsEffected = await db.insert(TABLE_NAME, {
      COLUMN_NAME: name,
      COLUMN_DESC: desc,
      COLUMN_IMAGE_PATH: imagePath,
      COLUMN_LAT: lat,
      COLUMN_LNG: lng,
    });
    return rowsEffected > 0;
  }

  /// Fetch All GeoTagged Items
  Future<List<Map<String, dynamic>>> getAllItems() async {
    var db = await getDB();
    return await db.query(TABLE_NAME);
  }

  /// Update an Existing Item
  Future<bool> updateItem({
    required int id,
    required String name,
    required String desc,
    String? imagePath,
    required double lat,
    required double lng,
  }) async {
    var db = await getDB();
    int rowsEffected = await db.update(
      TABLE_NAME,
      {
        COLUMN_NAME: name,
        COLUMN_DESC: desc,
        COLUMN_IMAGE_PATH: imagePath,
        COLUMN_LAT: lat,
        COLUMN_LNG: lng,
      },
      where: "$COLUMN_ID = ?",
      whereArgs: [id],
    );
    return rowsEffected > 0;
  }

  // ! Delete a GeoTagged Item
  Future<bool> deleteItem({required int id}) async {
    var db = await getDB();
    int rowsEffected = await db.delete(
      TABLE_NAME,
      where: '$COLUMN_ID = ?',
      whereArgs: [id],
    );
    return rowsEffected > 0;
  }
}
