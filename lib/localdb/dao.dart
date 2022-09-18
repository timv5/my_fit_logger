import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class Dao {

  static const dbName = 'my_fit_logger_db.db';
  static const dbSchema = 'CREATE TABLE my_logs (id TEXT PRIMARY KEY, title TEXT, body TEXT, create_date datetime);';

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await Dao.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetch(String table) async {
    final db = await Dao.database();
    return db.query(table);
  }

  static Future<void> delete(String table, String id) async {
    final db = await Dao.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  // the first time it will create db otherwise it will open it
  // onCreate -> you can initialize the database
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, dbName), onCreate: (db, version) {
      return db.execute(dbSchema);
    }, version: 1);
  }

}