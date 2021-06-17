import 'package:amanna/models/quote.dart';

abstract class QuoteRepository {
  Future<void> save(Quote quote);
  Future<List<Quote>> get(String tag);
  Future<void> delete(Quote quote);
}