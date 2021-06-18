import 'package:amanna/models/quote.dart';

abstract class QuoteRepository {
  Future<void> save(Quote quote);
  Future<List<Quote>> getByTag(String tag);
  Future<List<Quote>> getAll();
  Future<void> delete(Quote quote);
}