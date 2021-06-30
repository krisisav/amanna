import 'package:amanna/api/tag_response.dart';

const List<Map<String, dynamic>> response = [
  {
    "_id": "fvpORe-t",
    "name": "famous-quotes",
    "dateAdded": "2019-07-23",
    "dateModified": "2021-06-18",
    "__v": 0,
    "quoteCount": 1348
  },
  {
    "_id": "krXU-q4FE",
    "name": "friendship",
    "dateAdded": "2019-03-15",
    "dateModified": "2019-03-15",
    "__v": 0,
    "quoteCount": 187
  },
  {
    "_id": "k97A51Uf5",
    "name": "happiness",
    "dateAdded": "2019-06-27",
    "dateModified": "2019-06-27",
    "__v": 0,
    "quoteCount": 6
  },
  {
    "_id": "KBWnDu4rH",
    "name": "history",
    "dateAdded": "2021-01-30",
    "dateModified": "2021-01-30",
    "__v": 0,
    "quoteCount": 2
  },
  {
    "_id": "JCMoLDds9",
    "name": "inspirational",
    "dateAdded": "2020-01-27",
    "dateModified": "2021-06-18",
    "__v": 0,
    "quoteCount": 75
  },
];

final tagResponse = response.map((e) => TagResponse(
  id: e['_id'],
  name: e['name'],
  quoteCount: e['quoteCount'],
)).toList();