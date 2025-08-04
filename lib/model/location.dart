// 장소 정보를 표현하는 모델 클래스
class Location {
  final String title;
  final String category;
  final String roadAddress;

  Location({
    required this.title,
    required this.category,
    required this.roadAddress,
  });

// 네이버 API 응답을 Location 객체로 변환
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      // 네이버 검색 API에서 title에 HTML 태그가 포함될 수 있어 제거
      title: _removeHtmlTags(json['title']),
      category: json['category'],
      roadAddress: json['roadAddress'],
    );
  }

// HTML 태그 제거용 정적 메서드
  static String _removeHtmlTags(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}