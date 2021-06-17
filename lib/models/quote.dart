class Quote {
  final String id;
  final String content;
  final String author;
  final List<String> tags;

  Quote({
    required this.id,
    required this.content,
    required this.author,
    required this.tags,
  });

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'],
      content: map['content'],
      author: map['author'],
      tags: map['tags'].cast<String>().toList(),
    );
  }
}