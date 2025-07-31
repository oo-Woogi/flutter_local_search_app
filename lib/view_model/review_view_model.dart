import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/review_repository.dart';
import '../model/review.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

final reviewProvider = StateNotifierProvider.family<ReviewNotifier, List<Review>, String>(
  (ref, placeId) => ReviewNotifier(ref, placeId),
);

class ReviewNotifier extends StateNotifier<List<Review>> {
  final Ref _ref;
  final String placeId;

  ReviewNotifier(this._ref, this.placeId) : super([]) {
    loadReviews();
  }

  Future<void> loadReviews() async {
    final repo = _ref.read(reviewRepositoryProvider);
    final reviews = await repo.getReviews(placeId);
    state = reviews;
  }

  Future<void> addReview(Review review) async {
    final repo = _ref.read(reviewRepositoryProvider);
    await repo.addReview(review);
    await loadReviews();
  }

  Stream<List<Review>> reviewsStream() {
    final repo = _ref.read(reviewRepositoryProvider);
    return repo.reviewsStream(placeId);
  }
}

final reviewStreamProvider = StreamProvider.family<List<Review>, String>(
  (ref, placeId) {
    return ref.read(reviewRepositoryProvider).reviewsStream(placeId);
  },
);