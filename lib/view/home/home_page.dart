import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repository/location_repository.dart';
import '../../model/location.dart';
import '../../view/review/review_page.dart';

// 장소 정보를 보여주는 카드 위젯
class HomePageCard extends StatelessWidget {
  final String title;
  final String category;
  final String roadAddress;

  const HomePageCard({
    super.key,
    required this.title,
    required this.category,
    required this.roadAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 장소명
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // 카테고리
          Text(
            category,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          // 도로명 주소
          Text(
            roadAddress,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// 메인 홈화면 위젯 (검색 & 장소 목록)
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 현재 장소 목록 상태(Riverpod 사용)
    final locations = ref.watch(locationProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF1F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          // 검색 입력창
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: '검색할 지역',
              border: InputBorder.none,
            ),
            onSubmitted: (value) {
              // 엔터/검색 제출 시 검색 실행
              ref.read(locationProvider.notifier).search(value);
            },
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final place = locations[index];
          return GestureDetector(
            onTap: () {
              // 리시트 항목 탭 시 리뷰 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewPage(
                    placeId: place.title,
                    placeTitle: place.title,
                  ),
                ),
              );
            },
            // 장소 정보 카드
            child: HomePageCard(
              title: place.title,
              category: place.category,
              roadAddress: place.roadAddress,
            ),
          );
        },
      ),
    );
  }
}