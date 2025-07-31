

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