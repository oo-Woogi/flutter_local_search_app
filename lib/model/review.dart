import 'package:cloud_firestore/cloud_firestore.dart';

// 리뷰 데이터를 표현하는 모델 클래스
class Review {
  final String id;
  final String placeId;
  final String author;
  final String content;
  final DateTime timestamp;

// 생성자
  Review({
    this.id = '',
    required this.placeId,
    required this.author,
    required this.content,
    required this.timestamp,
  });

// Firestore에서 데이터를 읽어 Review 객체로 변환
  factory Review.fromJson(Map<String, dynamic> json, String id) {
    return Review(
      id: id,
      placeId: json['placeId'] as String,
      author: json['author'] as String,
      content: json['content'] as String,
      // Firestore의 Timestamp를 DateTime으로 변환
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

// Review 객체를 Firestore에 저장할 때 Map 형태로 변환
  Map<String, dynamic> toJson() {
    return {
      'placeId': placeId,
      'author': author,
      'content': content,
      // DateTime을 Firestore의 Timestamp로 변환
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}