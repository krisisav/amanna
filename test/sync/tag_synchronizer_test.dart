import 'package:amanna/api/api.dart';
import 'package:amanna/models/tag.dart';
import 'package:amanna/repositories/tag_repository.dart';
import 'package:amanna/sync/tag_synchronizer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../_resources/tag_response_test.dart';
import '../_resources/tag_test.dart';
import 'tag_synchronizer_test.mocks.dart';

@GenerateMocks([API, TagRepository])
void main() async {
  late MockAPI api;
  late MockTagRepository tagRepository;
  late TagSynchronizer tagSynchronizer;

  setUp(() {
    api = MockAPI();
    tagRepository = MockTagRepository();
    tagSynchronizer = TagSynchronizer(api, tagRepository);
  });

  test('if the database is empty, save all the results from the api', () async {
    //arrange
    when(tagRepository.getAll())
        .thenAnswer((_) => Future.value([]));
    when(api.getTags())
        .thenAnswer((_) => Future.value(tagResponse));

    //act
    await tagSynchronizer.saveTagsToDatabase();

    //assert
    expect(tagResponse.length, 5);
    verify(tagRepository.save(any)).called(5);
  });

  test('if the database has data, update it with the results from the api', () async {
    //arrange
    List<Tag> databaseTags = [...tags];

    when(tagRepository.getAll())
        .thenAnswer((_) => Future.value(databaseTags));
    when(api.getTags())
        .thenAnswer((_) => Future.value(tagResponse));

    //act
    await tagSynchronizer.saveTagsToDatabase();
    await tagRepository.getAll();

    //assert
    verify(tagRepository.save(any)).called(6);
    expect(databaseTags[2].quoteCount, 6);
    expect(databaseTags[5].name, 'history');
  });

  test('if the api returns an empty list, nothing gets saved', () async {
    //arrange
    when(tagRepository.getAll())
        .thenAnswer((_) => Future.value(tags));
    when(api.getTags())
        .thenAnswer((_) => Future.value([]));

    //act
    await tagSynchronizer.saveTagsToDatabase();

    //assert
    verifyNever(tagRepository.save(any));
  });
}
