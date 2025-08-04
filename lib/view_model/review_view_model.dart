import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/review_repository.dart';
import '../model/review.dart';

// 리뷰 관련 상태 관리 및 데이터 흐름을 위한 프로바이더 설정
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

// 각 장소에 대한 리뷰를 관리하는 상태 관리 프로바이더
final reviewProvider = StateNotifierProvider.family<ReviewNotifier, List<Review>, String>(
  (ref, placeId) => ReviewNotifier(ref, placeId),
);

// 리뷰 상태 관리 클래스
class ReviewNotifier extends StateNotifier<List<Review>> {
  final Ref _ref;
  final String placeId;

  ReviewNotifier(this._ref, this.placeId) : super([]) {
    loadReviews();
  }

// Firebase에서 해당 장소의 리뷰들을 불러와 상태에 저장
  Future<void> loadReviews() async {
    final repo = _ref.read(reviewRepositoryProvider);
    final reviews = await repo.getReviews(placeId);
    state = reviews;
  }

// 새로운 리뷰를 추가하고, 상태를 갱신
  Future<void> addReview(Review review) async {
    final repo = _ref.read(reviewRepositoryProvider);
    await repo.addReview(review);
    await loadReviews();
  }

// 실시간 리뷰 스트림 (Firestore의 변화 감지)
  Stream<List<Review>> reviewsStream() {
    final repo = _ref.read(reviewRepositoryProvider);
    return repo.reviewsStream(placeId);
  }
}

// 실시간 리뷰 스트림을 제공하는 Provider (장소별)
final reviewStreamProvider = StreamProvider.family<List<Review>, String>(
  (ref, placeId) {
    return ref.read(reviewRepositoryProvider).reviewsStream(placeId);
  },
);