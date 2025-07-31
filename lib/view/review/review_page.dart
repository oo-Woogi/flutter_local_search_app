import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_model/review_view_model.dart';
import '../../model/review.dart';

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
  int _rating = 5;

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
            final reviewsAsync = ref.watch(reviewStreamProvider(widget.placeId));
            return reviewsAsync.when(
              data: (reviews) {
                if (reviews.isEmpty) {
                  return const Center(child: Text('등록된 리뷰가 없습니다.'));
                }
                return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final rev = reviews[index];
                    return ListTile(
                      title: Text('${rev.author} (${rev.rating}/5)'),
                      subtitle: Text(rev.content),
                      trailing: Text(
                        "${rev.timestamp.year}.${rev.timestamp.month.toString().padLeft(2, '0')}.${rev.timestamp.day.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                onSubmitted: (value) async {
                  final newReview = Review(
                    placeId: widget.placeId,
                    author: '익명',
                    rating: 5,
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