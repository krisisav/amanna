import 'package:amanna/database/database.dart';
import 'package:amanna/models/quote.dart';
import 'package:amanna/repositories/quote_repository.dart';
import 'package:injectable/injectable.dart';

@Named('quote')
@Singleton(as: QuoteRepository)
class DbQuoteRepository implements QuoteRepository {
  final DatabaseProvider db;

  const DbQuoteRepository(this.db);

  @override
  Future<void> save(Quote quote) async {
    final database = await db.database;

    await database.transaction((txn) async {
      final int id = await txn.rawInsert(
        '''
          INSERT INTO ${DatabaseProvider.quotesTableName}(
            quote_id, 
            content, 
            author, 
            tags
          ) VALUES(?, ?, ?, ?)
        ''',
        [
          quote.id,
          quote.content,
          quote.author,
          quote.tags.join(',')
        ]
      );
      print('Successfully inserted quote with id = $id');
    });
  }

  @override
  Future<List<Quote>> getByTag(String tag) async {
    final database = await db.database;

    final quotesList = await database.rawQuery(
      '''
        SELECT * FROM ${DatabaseProvider.quotesTableName}
        WHERE tags LIKE ?
        ORDER BY id DESC
      ''',
      ['%$tag%']
    );
    
    return quotesList.map((quote) => Quote.fromMap(quote)).toList();
  }

  @override
  Future<List<Quote>> getAll() async {
    final database = await db.database;

    final quotesList = await database.rawQuery(
      '''
        SELECT * FROM ${DatabaseProvider.quotesTableName}
        ORDER BY id DESC
      '''
    );

    return quotesList.map((quote) => Quote.fromMap(quote)).toList();
  }

  @override
  Future<void> delete(Quote quote) async {
    final database = await db.database;

    final int id = await database.rawDelete(
      'DELETE FROM ${DatabaseProvider.quotesTableName} WHERE quote_id = ?',
      [quote.id]
    );
    print('Successfully deleted quote with id = $id');
  }

  @override
  Future<bool> contains(Quote quote) async {
    final database = await db.database;
    final queryId = await database.rawQuery(
      'SELECT query_id FROM ${DatabaseProvider.quotesTableName} WHERE quote_id = ?',
      [quote.id]
    );

    return queryId.isNotEmpty;
  }
}