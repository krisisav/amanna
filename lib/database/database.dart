import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final String _databaseName = 'amanna.db';
  static final int _databaseVersion = 1;
  static final String quotesTableName = 'quotes';
  static Database? _database;

  Future<Database> get database async {
    if(_database == null) {
      await _initDatabase();
    }

    return _database!;
  }

  Future<void> _initDatabase() async {
    final Directory documentsDir = await getApplicationDocumentsDirectory();
    final String path = join(documentsDir.path, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createTable(db, _databaseVersion);
      }
    );
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE $quotesTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          quote_id TEXT NOT NULL,
          content TEXT NOT NULL,
          author TEXT NOT NULL,
          tags TEXT NOT NULL
        );
      '''
    );
    print('Successfully created table quotes!');
  }
}