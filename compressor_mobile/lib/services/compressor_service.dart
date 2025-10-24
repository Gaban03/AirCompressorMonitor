part of '_services_lib.dart';

class CompressorService extends BaseService {
  CompressorService({required super.baseUrl});

  Future<CompressorDados> fetchDados() async {
    final jsonData = await get('compressor/dados?idCompressor=1');
    return CompressorDados.fromJson(jsonData);
  }
}
