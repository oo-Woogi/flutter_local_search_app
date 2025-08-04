import 'package:flutter/material.dart';

// 장소 정보를 보여주는 카드 위젯
class PlaceCard extends StatelessWidget {
  final String title; // 장소 이름
  final String category; // 장소 카테고리
  final String roadAddress; // 장소 도로 주소

  const PlaceCard({
    super.key,
    required this.title,
    required this.category,
    required this.roadAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(category, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 2),
            Text(roadAddress, style: const TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}