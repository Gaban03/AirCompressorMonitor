part of '_services_lib.dart';

class CompressorService extends BaseService {
  CompressorService({required super.baseUrl});

  Future<CompressorDados> fetchDados() async {
    final jsonData = await get('compressor/dados?idCompressor=1');
    return CompressorDados.fromJson(jsonData);
  }

  Future<List<CompressorDados>> fetchDadosDashboard() async {
    final jsonList = await get('compressor/dados-dashboard?idCompressor=1');

    return (jsonList as List)
        .map((item) => CompressorDados.fromJson(item))
        .toList();
  }

  Future<void> enviarComando(CompressorComandoDto comandoDto) async {
    await post('ordemRemota/comando', comandoDto.toJson());
  }

  Future<bool> fetchStatusLigado(int compressorId) async {
    final jsonData = await get('confirmacao/ligado?compressorId=$compressorId');
    return jsonData['ligado'] as bool;
  }
}
