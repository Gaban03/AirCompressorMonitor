part of "_view_model_lib.dart";

class CompressorControlViewModel extends BaseViewModel {
  final CompressorService _service = getIt<CompressorService>();

  bool ligado = false;
  String? dataEstado;

  Timer? _timer;
  final int compressorId = 1;

  void startMonitoringStatus() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => fetchStatus());
  }

  void stopMonitoringStatus() {
    _timer?.cancel();
  }

  Future<void> fetchStatus() async {
    try {
      clearError();
      final bool status = await _service.fetchStatusLigado(compressorId);

      if (status != ligado) {
        ligado = status;
        dataEstado = DateTime.now().toIso8601String();
        notifyListeners();
      }
    } catch (e) {
      setError('Erro ao obter status!');
    }
  }

  Future<void> toggleCompressor() async {
    try {
      setLoading(true);
      clearError();

      final novoEstado = !ligado;

      final comandoDto = CompressorComandoDto(
        compressorId: compressorId,
        comando: novoEstado,
      );

      await _service.enviarComando(comandoDto);

      ligado = novoEstado;
      dataEstado = DateTime.now().toIso8601String();
      notifyListeners();

      await Future.delayed(const Duration(seconds: 15));
      await fetchStatus();
    } catch (e) {
      setError('Erro ao enviar comando: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> carregarEstadoInicial() async {
    await fetchStatus();
  }

  @override
  void dispose() {
    stopMonitoringStatus();
    super.dispose();
  }
}
