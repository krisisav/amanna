import 'package:amanna/api/api.dart';
import 'package:amanna/api/tag_response.dart';
import 'package:amanna/models/tag.dart';
import 'package:amanna/repositories/tag_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart' show IterableExtension;

@singleton
class TagSynchronizer {
  final API api;
  final TagRepository tagRepository;

  const TagSynchronizer(this.api, @Named('tag') this.tagRepository);

  Future<void> saveTagsToDatabase() async {
    final tagsFromDatabase = await tagRepository.getAll();
    final tagsList = await api.getTags();

    for(TagResponse tagResponse in tagsList) {
      Tag? tag = tagsFromDatabase.firstWhereOrNull(
          (tag) => tag.id == tagResponse.id,
      );

      if(tag == null) {
        tagsFromDatabase.add(Tag(
          id: tagResponse.id,
          name: tagResponse.name,
          quoteCount: tagResponse.quoteCount
        ));
      } else {
        tag.name = tagResponse.name;
        tag.quoteCount = tagResponse.quoteCount;
      }
    }

    await tagRepository.saveAll(tagsFromDatabase);
  }
}
