import 'package:amanna/database/database.dart';
import 'package:amanna/models/tag.dart';
import 'package:amanna/repositories/tag_repository.dart';
import 'package:injectable/injectable.dart';

@Named('tag')
@Singleton(as: TagRepository)
class DbTagRepository implements TagRepository {
  final DatabaseProvider db;

  const DbTagRepository(this.db);

  @override
  Future<void> save(Tag tag) async {
    final database = await db.database;

    await database.transaction((txn) async {
      final int id = await txn.rawInsert(
        '''
          INSERT OR REPLACE INTO ${DatabaseProvider.tagsTableName}(
            tag_id,
            name, 
            quote_count
          ) VALUES(?, ?, ?)
        ''',
          [
            tag.id,
            tag.name,
            tag.quoteCount
          ]
      );
      print('Successfully inserted tag with id = $id');
    });
  }

  @override
  Future<List<Tag>> getAll() async {
    final database = await db.database;

    final tagsList = await database.rawQuery(
      'SELECT * FROM ${DatabaseProvider.tagsTableName}'
    );

    return tagsList.map((tag) => Tag.fromMap(tag)).toList();
  }
}