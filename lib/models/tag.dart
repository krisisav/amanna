import 'package:amanna/api/tag_response.dart';
import 'package:flutter/material.dart';

class Tag {
  final String id;
  String name;
  int quoteCount;

  IconData get icon {
    switch(name) {
      case 'famous-quotes' : return Icons.message_outlined;
      case 'friendship' : return Icons.people_outline_outlined;
      case 'happiness' : return Icons.wb_sunny_outlined;
      case 'inspirational' : return Icons.photo_size_select_actual_outlined;
      case 'life' : return Icons.home_work_outlined;
      case 'love' : return Icons.favorite_border_outlined;
      case 'technology' : return Icons.biotech_outlined;
      case 'wisdom' : return Icons.menu_book_outlined;
      default: return Icons.message_outlined;
    }
  }

  Tag({
    required this.id,
    required this.name,
    required this.quoteCount,
  });

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['tag_id'],
      name: map['name'],
      quoteCount: map['quote_count'],
    );
  }

  factory Tag.fromTagResponse(TagResponse tagResponse) {
    return Tag(
      id: tagResponse.id,
      name: tagResponse.name,
      quoteCount: tagResponse.quoteCount,
    );
  }
}