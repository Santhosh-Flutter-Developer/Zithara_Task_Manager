import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zithara_task_manager/models/task.dart';

class DbHelper {
  static Database? _db;
  static const int _version = 2; // Incremented version
  static const String _tableName = "tasks";

  /// Initialize the database
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}/task.db';

      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE $_tableName (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT, 
              description TEXT, 
              startDate TEXT,
              endDate TEXT, 
              startTime TEXT, 
              endTime TEXT, 
              remind INTEGER, 
              repeat TEXT, 
              color INTEGER, 
              isCompleted INTEGER
            )
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < newVersion) {
            await db.execute('ALTER TABLE $_tableName ADD COLUMN startDate TEXT');
            await db.execute('ALTER TABLE $_tableName ADD COLUMN endDate TEXT');
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error initializing database: $e");
      }
    }
  }

  /// Insert a task into the database
  static Future<int> insert(Task? task) async {
    if (kDebugMode) {
      print("Insert function called");
    }
    if (_db == null) {
      await initDb(); // Ensure database is initialized
    }
    return await _db?.insert(_tableName, task!.toJson()) ?? 0;
  }

  /// Query all tasks from the database
  static Future<List<Map<String, dynamic>>> query() async {
    if (kDebugMode) {
      print("Query function called");
    }
    if (_db == null) {
      await initDb(); // Ensure database is initialized
    }
    return await _db!.query(_tableName);
  }

  /// Delete a task
  static Future<int> delete(Task task) async {
    if (kDebugMode) {
      print("Delete function called");
    }
    if (_db == null) {
      await initDb(); // Ensure database is initialized
    }
    return await _db!.delete(_tableName, where: "id=?", whereArgs: [task.id]);
  }

  /// Update task completion status
  static Future<int> update(int id) async {
    if (kDebugMode) {
      print("Update function called");
    }
    if (_db == null) {
      await initDb(); // Ensure database is initialized
    }
    return await _db!.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id = ?
    ''', [1, id]);
  }

  /// Delete the database file (optional)
  static Future<void> deleteDatabaseFile() async {
    String path = '${await getDatabasesPath()}/task.db';
    await deleteDatabase(path);
    if (kDebugMode) {
      print("Database deleted successfully.");
    }
  }

  /// Print table schema for debugging
  static Future<void> printTableSchema() async {
    if (_db == null) {
      await initDb();
    }
    List<Map<String, dynamic>> schema = await _db!.rawQuery("PRAGMA table_info($_tableName)");
    for (var column in schema) {
      if (kDebugMode) {
        print("Column: ${column['name']}, Type: ${column['type']}");
      }
    }
  }
}
