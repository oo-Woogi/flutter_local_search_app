import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../model/location.dart';

// 네이버 지역 검색 API 연동을 담당하는 Repository 클래스
class LocationRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://openapi.naver.com/v1/search/local.json';

// 네이버 API 인증 정보
  static const String _clientId = 'sLuN5YDJ1JPiNTUbysOD';
  static const String _clientSecret = 'apUfNMokjj';

// 검색 쿼리로 네이버 지역 검색 API 호출, 결과를 Location 리스트로 변환
  Future<List<Location>> search(String query) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'query': query, // 검색어
          'display': 10, // 최대 10개 결과
        },
        options: Options(
          headers: {
            'X-Naver-Client-Id': _clientId,
            'X-Naver-Client-Secret': _clientSecret,
          },
        ),
      );
      // API 결과에서 items 리스트 추출 후 Location 객체로 변환
      final items = response.data['items'] as List<dynamic>;
      return items.map((e) => Location.fromJson(e)).toList();
    } catch (e, stack) {
      // 오류 발생 시 콘솔 출력 후 빈 리스트 반환
      print('Location search failed: $e');
      print('Stack trace: $stack');
      return [];
    }
  }
}

// 장소 리스트 상태를 관리하는 Riverpod Provider
final locationProvider =
    StateNotifierProvider.autoDispose<LocationNotifier, List<Location>>(
  (ref) => LocationNotifier(),
);

// 실제 검색 상태와 로직을 관리하는 StateNorifier
class LocationNotifier extends StateNotifier<List<Location>> {
  final LocationRepository _repository = LocationRepository();

  LocationNotifier() : super([]);

// 검색 결과를 상태로 업데이트
  Future<void> search(String query) async {
    final results = await _repository.search(query);
    state = results;
  }
}