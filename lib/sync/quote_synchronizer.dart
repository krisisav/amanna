import 'package:amanna/api/api.dart';
import 'package:amanna/repositories/quote_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class QuoteSynchronizer {
  final API api;
  final QuoteRepository quoteRepository;

  const QuoteSynchronizer(this.api, @Named('quote') this.quoteRepository);

  Future<void> saveQuoteToDatabase(String tag) async {
    final quote = await api.getQuoteByTag(tag);

    if(quote == null) {
      return;
    }

    final bool isAlreadySaved = await quoteRepository.contains(quote);

    if(!isAlreadySaved) {
      await quoteRepository.save(quote);
    }
  }
}