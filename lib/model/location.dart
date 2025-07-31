class Location {
  final String title;
  final String category;
  final String roadAddress;

  Location({
    required this.title,
    required this.category,
    required this.roadAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      title: _removeHtmlTags(json['title']),
      category: json['category'],
      roadAddress: json['roadAddress'],
    );
  }

  static String _removeHtmlTags(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}