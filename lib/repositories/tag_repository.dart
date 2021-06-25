import 'package:amanna/models/tag.dart';

abstract class TagRepository {
  Future<void> saveAll(List<Tag> tags);
  Future<List<Tag>> getAll();
}