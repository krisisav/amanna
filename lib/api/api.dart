import 'package:amanna/models/quote.dart';
import 'package:amanna/models/tag.dart';
import 'package:amanna/utilities/helpers.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class API {
  static final baseUrl = 'https://api.quotable.io';

  @lazySingleton
  Dio get dio => Dio();

  Future<List<Map<String, dynamic>>?> loadPageOfQuotes() async {
    int page = getRandomPageNumber(1, 94);

    final url = '$baseUrl/quotes?page=$page';

    try {
      final Response response = await dio.get(url);
      print('Successfully loaded quotes from page $page!');

      return response.data['results']!;
    } on DioError catch (error) {
      print('${error.type} : ${error.message}');
    }
  }

  Future<Quote?> getQuoteByTag(String tag) async {
    final url = '$baseUrl/random?tags=$tag';

    try {
      final Response response = await dio.get(url);
      print('Successfully loaded a random quote with tag = $tag');

      return Quote.fromMap(response.data);
    } on DioError catch (error) {
      print('${error.type} : ${error.message}');
    }
  }

    final url = '$baseUrl/tags';

    try {
      final Response response = await dio.get(url);
      print('Successfully loaded tags!');

      final results = response.data.cast<Map<String, dynamic>>();
      results.forEach((e) {
        if(e['quoteCount'] > 5) {
            id: e['_id'],
            name: e['name'],
            quoteCount: e['quoteCount'],
          ));
        }
      });
    } on DioError catch (error) {
      print('${error.message} : ${error.response}');
    }

    return tags;
  }
}