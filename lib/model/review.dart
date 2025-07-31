

import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;

  final String placeId;

  final String author;

  final int rating;

  final String content;

  final DateTime timestamp;

  Review({
    this.id = '',
    required this.placeId,
    required this.author,
    required this.rating,
    required this.content,
    required this.timestamp,
  });

  factory Review.fromJson(Map<String, dynamic> json, String id) {
    return Review(
      id: id,
      placeId: json['placeId'] as String,
      author: json['author'] as String,
      rating: (json['rating'] as num).toInt(),
      content: json['content'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placeId': placeId,
      'author': author,
      'rating': rating,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}