import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
class DBHelper {

  static Future<Database> database() async{

    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath,'places.db'),version: 1,onCreate: (db, ver) async {
      return await db.execute('CREATE TABLE places_table(id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL , longitude REAL)');
    });


  }

  static Future<void> insert(String tableName, Map<String, Object> data) async{

    final db = await DBHelper.database();
    db.insert(tableName, data,conflictAlgorithm: sql.ConflictAlgorithm.replace);

  }

  static Future<List<Map<String,dynamic>>> getData (String tableName) async{
    final db = await DBHelper.database();
    return db.query(tableName);

  }

}