import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_model/review_view_model.dart';
import '../../model/review.dart';

// 리뷰 페이지: 특정 장소에 대한 리뷰를 보여주고 작성할 수 있는 페이지
class ReviewPage extends StatefulWidget {
  final String placeId;
  final String placeTitle;

  const ReviewPage({
    Key? key,
    required this.placeId,
    required this.placeTitle,
  }) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _authorController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.placeTitle),
        backgroundColor: const Color(0xFFFDF1F7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(
          builder: (context, ref, child) {
            // 해당 장소의 리뷰 목록을 실시간으로 받아옴
            final reviewsAsync = ref.watch(reviewStreamProvider(widget.placeId));
            return reviewsAsync.when(
              data: (reviews) {
                if (reviews.isEmpty) {
                  // 리뷰가 없을 경우 안내 메시지 표시
                  return const Center(child: Text('등록된 리뷰가 없습니다.'));
                }
                // 리뷰가 있을 경우 리스트로 보여줌
                return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final rev = reviews[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rev.content,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          // 작성 일시(마이크로초까지 표기)
                          Text(
                            "${rev.timestamp.year}.${rev.timestamp.month.toString().padLeft(2, '0')}.${rev.timestamp.day.toString().padLeft(2, '0')} "
                            "${rev.timestamp.hour.toString().padLeft(2, '0')}:${rev.timestamp.minute.toString().padLeft(2, '0')}:${rev.timestamp.second.toString().padLeft(2, '0')}"
                            ".${rev.timestamp.microsecond.toString().padLeft(6, '0')}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('에러 발생: $e')),
            );
          },
        ),
      ),
      // 리뷰 작성 입력창 (하단 고정)
      bottomNavigationBar: SafeArea(
        child: Consumer(
          builder: (context, ref, _) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: '리뷰를 입력하세요',
                  border: InputBorder.none,
                ),
                // 엔터 입력 시 리뷰 추가 및 입력창 비움
                onSubmitted: (value) async {
                  final newReview = Review(
                    placeId: widget.placeId,
                    author: '익명',
                    content: value,
                    timestamp: DateTime.now(),
                  );
                  await ref.read(reviewProvider(widget.placeId).notifier).addReview(newReview);
                  _contentController.clear();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}