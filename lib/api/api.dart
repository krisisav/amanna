import 'package:dio/dio.dart';

class API {
  final _dio = Dio();
  static final baseUrl = 'https://api.quotable.io';

  Future<List<Map<String, dynamic>>?> loadPageOfQuotes(int page) async {
    assert(page > 0 && page < 95);

  Future<List<Map<String, dynamic>>?> loadPageOfQuotes() async {
    int page = getRandomPageNumber(1, 94);

    final url = '$baseUrl/quotes?page=$page';

    try {
      final Response response = await _dio.get(url);
      print('Successfully loaded quotes from page $page!');

      return response.data['results']!;
    } on DioError catch (error) {
      print('${error.type} : ${error.message}');
    }
  }

  Future getTags() async {
    final url = '$baseUrl/tags';

    try {
      final Response response = await _dio.get(url);
      print('Successfully loaded tags!');

      return response.data!;
    } on DioError catch (error) {
      print('${error.message} : ${error.response}');
    }
  }
}