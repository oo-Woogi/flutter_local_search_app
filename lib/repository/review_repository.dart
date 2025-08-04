import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/review.dart';

// 리뷰 관련 Firestore 접근 기능을 담당하는 Repository 클래스
class ReviewRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _reviewsCollection =
      FirebaseFirestore.instance.collection('reviews');

// 새로운 리뷰를 Firestore에 추가
  Future<void> addReview(Review review) async {
    await _reviewsCollection.add(review.toJson());
  }

// 특정 장소의 리뷰 목록을 최신순으로 불러오기
  Future<List<Review>> getReviews(String placeId) async {
    try {
      final querySnapshot = await _reviewsCollection
          .where('placeId', isEqualTo: placeId)
          .orderBy('timestamp', descending: true)
          .get();

// 각 문서를 Review 객체로 변환해 리스트로 반환
      return querySnapshot.docs
          .map((doc) => Review.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } on FirebaseException catch (e) {
      // Firestore 인덱스 오류 발생 시 안내 출력 후 빈 리스트 반환
      if (e.code == 'failed-precondition') {
        print('Firestore index missing for placeId/timestamp query: ${e.message}');
        return [];
      }
      rethrow;
    }
  }

// 특정 장소의 리뷰를 실시간 반환
  Stream<List<Review>> reviewsStream(String placeId) {
    return _reviewsCollection
        .where('placeId', isEqualTo: placeId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Review.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }
}