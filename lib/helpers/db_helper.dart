import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Future<Database> database() async{
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath,'places.db'),     // join is used to create a new path by combining old path with a string
        onCreate: (db, version){    // If table doesn't exist, it will create one
          return db.execute('CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');

        }, version: 1);
  }

  static Future<void> insert(String table, Map<String,Object> data) async{
    final db = await DBHelper.database();
    db.insert(
        table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace    // It will replace if data already exist in the table
    );
  }

  static Future<List<Map<String,dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);   // It returns a list of map
  }
}