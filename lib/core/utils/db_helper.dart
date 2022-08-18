import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'employeesdata.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE employees(id INTEGER PRIMARY KEY, name TEXT, username TEXT, email TEXT, profileImage TEXT, phone TEXT, website TEXT, address TEXT, company TEXT)');
    }, version: 1);
  }

  static Future<void> insert(Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert('employees', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData({
    String? name,
    String? email,
  }) async {
    final db = await DBHelper.database();
    if (name != null) {
      return db.query('employees WHERE name=$name');
    } else if (email != null) {
      return db.query('employees WHERE email=$email');
    } else {
      return db.query('employees');
    }
  }
}
