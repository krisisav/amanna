import 'package:amanna/api/api.dart';
import 'package:amanna/main.dart';

class Tags {
  final List<Tag> _tags = [];

  Future<List<Tag>> get tags async {
    if(_tags.isEmpty) {
      final api = getIt.get<API>();
      final results = await api.getTags() ..cast<Map<String, dynamic>>();

      results.forEach((e) {
        if(e['quoteCount'] > 0) {
          _tags.add(Tag(
            name: e['name'],
            quoteCount: e['quoteCount'],
          ));
        }
      });
    }

    return _tags;
  }
}

class Tag {
  final String name;
  final int quoteCount;

  const Tag({
    required this.name,
    required this.quoteCount,
  });
}