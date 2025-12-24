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

  // ---------------------- GET ------------------------
  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(url, headers: defaultHeaders);
      _validateResponse(response);

      if (response.statusCode == 204 || response.body.isEmpty) {
        return null;
      }

      return json.decode(response.body);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // ---------------------- POST ------------------------
  Future<dynamic> post(String endpoint, dynamic body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: defaultHeaders,
        body: json.encode(body),
      );

      _validateResponse(response);

      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // ---------------------- PUT ------------------------
  Future<dynamic> put(String endpoint, dynamic body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.put(
        url,
        headers: defaultHeaders,
        body: json.encode(body),
      );

      _validateResponse(response);

      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // ---------------------- PATCH ------------------------
  Future<dynamic> patch(String endpoint, {dynamic body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.patch(
        url,
        headers: defaultHeaders,
        body: body != null ? json.encode(body) : null,
      );

      _validateResponse(response);

      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // ---------------------- DELETE ------------------------
  Future<dynamic> delete(String endpoint, {dynamic body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.delete(
        url,
        headers: defaultHeaders,
        body: body != null ? json.encode(body) : null,
      );

      _validateResponse(response);

      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // ---------------------- VALIDATION ------------------------
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
      if (e.details != null) print('➡️ DETAILS: ${e.details}');
    } else {
      print('❌ [API ERROR]: $e');
    }
  }
}
