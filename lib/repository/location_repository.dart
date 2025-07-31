import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../model/location.dart';

class LocationRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://openapi.naver.com/v1/search/local.json';

  static const String _clientId = 'sLuN5YDJ1JPiNTUbysOD';
  static const String _clientSecret = 'apUfNMokjj';

  Future<List<Location>> search(String query) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'query': query,
          'display': 10,
        },
        options: Options(
          headers: {
            'X-Naver-Client-Id': _clientId,
            'X-Naver-Client-Secret': _clientSecret,
          },
        ),
      );
      final items = response.data['items'] as List<dynamic>;
      return items.map((e) => Location.fromJson(e)).toList();
    } catch (e, stack) {
      print('Location search failed: $e');
      print('Stack trace: $stack');
      return [];
    }
  }
}

final locationProvider =
    StateNotifierProvider.autoDispose<LocationNotifier, List<Location>>(
  (ref) => LocationNotifier(),
);

class LocationNotifier extends StateNotifier<List<Location>> {
  final LocationRepository _repository = LocationRepository();

  LocationNotifier() : super([]);

  Future<void> search(String query) async {
    final results = await _repository.search(query);
    state = results;
  }
}