import 'package:amanna/models/tag.dart';

const List<Map<String, dynamic>> data = [
  {
    "tag_id": "fvpORe-t",
    "name": "famous-quotes",
    "quote_count": 1348
  },
  {
    "tag_id": "krXU-q4FE",
    "name": "friendship",
    "quote_count": 187
  },
  {
    "tag_id": "k97A51Uf5",
    "name": "happiness",
    "quote_count": 10
  },
  {
    "tag_id": "JCMoLDds9",
    "name": "inspirational",
    "quote_count": 75
  },
  {
    "tag_id": "6J1qxxuj3",
    "name": "wisdom",
    "quote_count": 315
  },
];

final tags = data.map((map) => Tag.fromMap(map)).toList();