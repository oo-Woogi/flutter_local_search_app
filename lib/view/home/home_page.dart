import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String title;
  final String category;
  final String roadAddress;

  const PlaceCard({
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _places = [
    {
      'title': '삼성1동 주민센터',
      'category': '공공,사회기관>행정복지센터',
      'roadAddress': '서울특별시 강남구 봉은사로 616 삼성1동 주민센터',
    },
    {
      'title': '삼성2동 주민센터',
      'category': '공공,사회기관>행정복지센터',
      'roadAddress': '서울특별시 강남구 봉은사로 419 삼성2동주민센터',
    },
    {
      'title': '코엑스',
      'category': '문화,예술>컨벤션센터',
      'roadAddress': '서울특별시 강남구 영동대로 513',
    },
    {
      'title': '코엑스아쿠아리움',
      'category': '관광,체험>아쿠아리움',
      'roadAddress': '서울특별시 강남구 영동대로 513',
    },
    {
      'title': '현대백화점 무역센터점',
      'category': '쇼핑,유통>백화점',
      'roadAddress': '서울특별시 강남구 테헤란로 517',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: '삼성동',
              border: InputBorder.none,
            ),
            onSubmitted: (value) {
              // 검색 기능 연결 예정
            },
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _places.length,
        itemBuilder: (context, index) {
          final place = _places[index];
          return PlaceCard(
            title: place['title'] ?? '',
            category: place['category'] ?? '',
            roadAddress: place['roadAddress'] ?? '',
          );
        },
      ),
    );
  }
}