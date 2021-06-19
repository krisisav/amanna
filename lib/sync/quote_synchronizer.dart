import 'package:amanna/api/api.dart';
import 'package:amanna/models/quote.dart';
import 'package:amanna/repositories/quote_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class QuoteSynchronizer {
  final API api;
  final QuoteRepository quoteRepository;

  const QuoteSynchronizer(this.api, @Named('sqlite') this.quoteRepository);

  Future<void> saveQuotesToDatabase() async {
    final quotesList = await api.loadPageOfQuotes();

    if(quotesList != null && quotesList.isNotEmpty) {
      quotesList.forEach((mappedQuote) async {
        final quote = Quote.fromMap(mappedQuote);

        if(await quoteRepository.contains(quote) == false) {
          await quoteRepository.save(Quote.fromMap(mappedQuote));
        }
      });
    }
  }
}