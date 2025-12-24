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

  Future<PageDTO<CompressorFalhasDto>> fetchFalhas({
    required int idCompressor,
    int page = 0,
    int size = 1,
  }) async {
    final jsonData = await get(
      'compressor/falhas?idCompressor=$idCompressor&page=$page&size=$size',
    );

    if (jsonData == null) {
      return PageDTO(
        content: [],
        totalPages: 1,
        totalElements: 0,
        page: page,
        size: size,
        first: true,
        last: true,
      );
    }

    return PageDTO.fromJson(
      jsonData,
      (json) => CompressorFalhasDto.fromJson(json),
    );
  }
}
