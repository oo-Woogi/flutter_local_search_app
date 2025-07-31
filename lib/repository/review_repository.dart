import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/review.dart';

class ReviewRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _reviewsCollection =
      FirebaseFirestore.instance.collection('reviews');

  Future<void> addReview(Review review) async {
    await _reviewsCollection.add(review.toJson());
  }

  Future<List<Review>> getReviews(String placeId) async {
    try {
      final querySnapshot = await _reviewsCollection
          .where('placeId', isEqualTo: placeId)
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Review.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } on FirebaseException catch (e) {
      if (e.code == 'failed-precondition') {
        print('Firestore index missing for placeId/timestamp query: ${e.message}');
        return [];
      }
      rethrow;
    }
  }

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