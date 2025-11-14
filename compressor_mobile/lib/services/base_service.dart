part of '_services_lib.dart';

class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final String? details;

  ApiException({this.statusCode, required this.message, this.details});

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message, details: $details)';
}

abstract class BaseService {
  final String baseUrl;

  final Map<String, String> defaultHeaders = const {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  BaseService({required this.baseUrl});

  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(url, headers: defaultHeaders);
      _validateResponse(response);

      return json.decode(response.body);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: defaultHeaders,
        body: json.encode(body),
      );
      _validateResponse(response);
      return json.decode(response.body);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.put(
        url,
        headers: defaultHeaders,
        body: json.encode(body),
      );
      _validateResponse(response);
      return json.decode(response.body);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<void> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.delete(url, headers: defaultHeaders);
      _validateResponse(response);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _validateResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        statusCode: response.statusCode,
        message: response.reasonPhrase ?? 'Erro desconhecido',
        details: response.body,
      );
    }
  }

  void _handleError(Object e) {
    if (e is ApiException) {
      print('⚠️ [API ERROR]: ${e.statusCode} - ${e.message}');
    } else {
      print('❌ [API ERROR]: $e');
    }
  }
}
