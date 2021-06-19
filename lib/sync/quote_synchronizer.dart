import 'package:amanna/api/api.dart';
import 'package:amanna/main.dart';
import 'package:amanna/models/quote.dart';
import 'package:amanna/repositories/quote_repository.dart';

class QuoteSynchronizer {
  final _api = getIt.get<API>();
  final _quoteRepository = getIt.get<QuoteRepository>();

  Future<void> saveQuotesToDatabase() async {
    final quotesList = await api.loadPageOfQuotes();

    if(quotesList != null && quotesList.isNotEmpty) {
      quotesList.forEach((mappedQuote) async {
        final quote = Quote.fromMap(mappedQuote);

        if(await _quoteRepository.contains(quote) == false) {
          await _quoteRepository.save(Quote.fromMap(mappedQuote));
        }
      });
    }
  }
}