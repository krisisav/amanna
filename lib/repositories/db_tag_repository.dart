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
  Future<void> saveAll(List<Tag> tags) async {
    final database = await db.database;

    tags.forEach((tag) async {
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
    });
  }

  @override
  Future<List<Tag>> getAll() async {
    final database = await db.database;

    final tagsList = await database.rawQuery(
      '''
        SELECT * FROM ${DatabaseProvider.tagsTableName}
        ORDER BY id DESC
      '''
    );

    return tagsList.map((tag) => Tag.fromMap(tag)).toList();
  }
}