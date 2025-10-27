part of "_view_model_lib.dart";

class CompressorDadosViewModel extends BaseViewModel {
  static const int maxPoints = 5;

  final CompressorService _service = getIt<CompressorService>();

  List<FlSpot> temperaturaSpots = [];
  List<String> labels = [];

  double temperaturaAmbiente = 0;
  String dataHora = '';
  double tempo = 0;

  Timer? _timer;

  void startFetching() {
    fetchDados();
    _timer = Timer.periodic(const Duration(seconds: 600), (_) => fetchDados());
  }

  void stopFetching() {
    _timer?.cancel();
  }

  Future<void> fetchDados() async {
    try {
      setLoading(true);
      clearError();

      final CompressorDados dados = await _service.fetchDados();

      double tempAmb = dados.temperaturaAmbiente.toDouble();
      String hora = dados.dataHora.toString();

      tempo += 1;

      temperaturaAmbiente = tempAmb;
      dataHora = hora;

      temperaturaSpots.add(FlSpot(tempo, temperaturaAmbiente));
      labels.add(dataHora.length >= 19 ? dataHora.substring(11, 19) : dataHora);

      if (temperaturaSpots.length > maxPoints) {
        temperaturaSpots.removeAt(0);
        labels.removeAt(0);
      }

      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    stopFetching();
    super.dispose();
  }
}
