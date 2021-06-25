import 'dart:io';
import 'package:amanna/services/get_it_setup.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

@singleton
class DatabaseProvider {
  static final String _databaseName = 'amanna.db';
  static final int _databaseVersion = 1;
  static final String quotesTableName = 'quotes';
  static final String tagsTableName = 'tags';
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
        await _createTableQuotes(db, _databaseVersion);
        await _createTableTags(db, _databaseVersion);
      }
    );
  }

  Future<void> _createTableQuotes(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE $quotesTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          quote_id TEXT UNIQUE NOT NULL,
          content TEXT NOT NULL,
          author TEXT NOT NULL,
          tags TEXT NOT NULL
        );
      '''
    );
    print('Successfully created table quotes!');
  }

  Future<void> _createTableTags(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE $tagsTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tag_id TEXT UNIQUE NOT NULL,
          name TEXT NOT NULL,
          quote_count INTEGER NOT NULL
        );
      '''
    );
    print('Successfully created table tags!');
  }
}