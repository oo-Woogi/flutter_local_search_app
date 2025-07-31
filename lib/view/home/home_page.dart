


import 'package:flutter/material.dart';
import '../widget/place_card.dart';

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
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: '삼성동',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            // TODO: 검색 기능 연결 예정
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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