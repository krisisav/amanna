// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//
// class MockDatabaseProvider {
//   static Database? _database;
//
//   Future<Database> get database async {
//     if(_database == null) {
//       await _initDatabase();
//     }
//
//     return _database!;
//   }
//
//   Future<void> _initDatabase() async {
//     sqfliteFfiInit();
//
//     DatabaseFactory databaseFactory = databaseFactoryFfi;
//     _database = await databaseFactory.openDatabase(inMemoryDatabasePath);
//     await _database!.execute(
//         '''
//         CREATE TABLE quote (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           quote_id TEXT UNIQUE NOT NULL,
//           content TEXT NOT NULL,
//           author TEXT NOT NULL,
//           tags TEXT NOT NULL
//         );
//       '''
//     );
//     await _database!.execute(
//       '''
//         CREATE TABLE tag (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           tag_id TEXT UNIQUE NOT NULL,
//           name TEXT NOT NULL,
//           quote_count INTEGER NOT NULL
//         )
//       '''
//     );
//     await _database!.close();
//   }
// }