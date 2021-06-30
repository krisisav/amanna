// import 'package:amanna/api/tag_response.dart';
// import 'package:amanna/models/tag.dart';
// import 'package:amanna/repositories/db_tag_repository.dart';
// import 'package:amanna/repositories/tag_repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import '../api/tag_response_test.dart';
//
//
// // Generate a MockClient using the Mockito package.
// // Create new instances of this class in each test.
// @GenerateMocks([DbTagRepository])
// class MockDbTagRepository extends Mock implements DbTagRepository{
//
// }
// void main() {
//   List<TagResponse> tagsResponseList = [];
//   List<Tag> tags = [];
//
//   setUp(() {
//     response.forEach((map) {
//       tagsResponseList.add(TagResponse(
//         id: map['_id'],
//         name: map['name'],
//         quoteCount: map['quoteCount'],
//       ));
//     });
//     tagsResponseList.forEach((tagResponse) {
//       tags.add(Tag.fromTagResponse(tagResponse));
//     });
//   });
// }