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

  Future<List<Tag>> getTags() async {
    final url = '$baseUrl/tags';
    final List<Tag> tags = [];

    try {
      final Response response = await dio.get(url);
      print('Successfully loaded tags!');

      final results = response.data.cast<Map<String, dynamic>>();
      results.forEach((e) {
        if(e['quoteCount'] > 0) {
          tags.add(Tag(
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