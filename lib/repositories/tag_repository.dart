import 'package:amanna/models/tag.dart';

abstract class TagRepository {
  Future<void> save(Tag tag);
  Future<List<Tag>> getAll();
}