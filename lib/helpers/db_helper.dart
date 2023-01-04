import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

const userDB = 'places.db';
const userPlaceTable = 'user_places';
const userId = 'id';
const userTitle = 'title';
const userPlaceImage = 'image';
const placeLocLat = 'loc_lat';
const placeLocLong = 'loc_long';
const placeAddress = 'address';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, userDB), onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE $userPlaceTable ($userId TEXT PRIMARY KEY, $userTitle '
        'TEXT, $userPlaceImage TEXT, $placeLocLat REAL, $placeLocLong REAL, '
        '$placeAddress TEXT)',
      );
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object?> data) async {
    final db = await DBHelper.database();
    // print(data);
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
