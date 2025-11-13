part of '_view_model_lib.dart';

class CompressorDadosViewModel extends BaseViewModel {
  static const int maxPoints = 5;

  final CompressorService _service = getIt<CompressorService>();

  List<FlSpot> temperaturaSpots = [];
  List<FlSpot> pressaoSpots = [];
  List<String> labels = [];

  double temperaturaAmbiente = 0;
  double temperaturaArComprimido = 0;
  double temperaturaOrvalho = 0;
  double temperaturaOleo = 0;

  double pressaoAlivio = 0;
  double pressaoArComprimido = 0;
  double pressaoCarga = 0;

  String mensagemEstado = 'Carregando...';
  bool ligado = false;

  double ultimaTemperatura = 0;
  double ultimaPressao = 0;
  String ultimaHora = "--:--:--";

  double minY = 0;
  double maxY = 100;

  Timer? _timer;
  Timer? _estadoTimer;

  double tempo = 0;

  void startTemperature(TipoTemperatura tipo) {
    stopFetching();
    temperaturaSpots = [];
    labels = [];
    tempo = 0;

    switch (tipo) {
      case TipoTemperatura.ambiente:
        minY = 0;
        maxY = 60;
        _fetchDashboardTemperatura((d) => d.temperaturaAmbiente.toDouble());
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => _fetchDashboardTemperatura(
            (d) => d.temperaturaAmbiente.toDouble(),
          ),
        );
        break;

      case TipoTemperatura.arComprimido:
        minY = 0;
        maxY = 90;
        _fetchDashboardTemperatura((d) => d.temperaturaArComprimido.toDouble());
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => _fetchDashboardTemperatura(
            (d) => d.temperaturaArComprimido.toDouble(),
          ),
        );
        break;

      case TipoTemperatura.orvalho:
        minY = 0;
        maxY = 15;
        _fetchDashboardTemperatura((d) => d.temperaturaOrvalho.toDouble());
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => _fetchDashboardTemperatura(
            (d) => d.temperaturaOrvalho.toDouble(),
          ),
        );
        break;

      case TipoTemperatura.oleo:
        minY = 0;
        maxY = 80;
        _fetchDashboardTemperatura((d) => d.temperaturaOleo.toDouble());
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => _fetchDashboardTemperatura(
            (d) => d.temperaturaOleo.toDouble(),
          ),
        );
        break;
    }
  }

  Future<void> _fetchDashboardTemperatura(
    double Function(CompressorDados d) selector,
  ) async {
    try {
      setLoading(true);

      final lista = await _service.fetchDadosDashboard();
      final ordered = lista.reversed.toList();

      temperaturaSpots.clear();
      labels.clear();
      tempo = 0;

      for (final dado in ordered) {
        tempo += 1;
        final value = selector(dado);

        temperaturaSpots.add(FlSpot(tempo, value));
        labels.add(_formatHora(dado.dataHora.toString()));
      }

      if (lista.isNotEmpty) {
        final ultimo = lista.first;

        ultimaTemperatura = selector(ultimo);
        ultimaHora = _formatHora(ultimo.dataHora.toString());
      }

      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void startPressure(TipoPressao tipo) {
    stopFetching();
    pressaoSpots = [];
    labels = [];
    tempo = 0;

    switch (tipo) {
      case TipoPressao.arComprimido:
        minY = 0;
        maxY = 10;
        _fetchDashboardPressao((d) => d.pressaoArComprimido.toDouble());
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => _fetchDashboardPressao(
            (d) => d.pressaoArComprimido.toDouble(),
          ),
        );
        break;

      case TipoPressao.carga:
        minY = 0;
        maxY = 8;
        _fetchDashboardPressao((d) => d.pressaoCarga.toDouble());
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => _fetchDashboardPressao(
            (d) => d.pressaoCarga.toDouble(),
          ),
        );
        break;

      case TipoPressao.alivio:
        minY = 0;
        maxY = 12;
        _fetchDashboardPressao((d) => d.pressaoAlivio.toDouble());
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => _fetchDashboardPressao(
            (d) => d.pressaoAlivio.toDouble(),
          ),
        );
        break;
    }
  }

  Future<void> _fetchDashboardPressao(
    double Function(CompressorDados d) selector,
  ) async {
    try {
      setLoading(true);

      final lista = await _service.fetchDadosDashboard();
      final ordered = lista.reversed.toList();

      pressaoSpots.clear();
      labels.clear();
      tempo = 0;

      for (final dado in ordered) {
        tempo += 1;
        final value = selector(dado);

        pressaoSpots.add(FlSpot(tempo, value));
        labels.add(_formatHora(dado.dataHora.toString()));
      }

      if (lista.isNotEmpty) {
        final ultimo = lista.first;
        final ultimoValor = selector(ultimo);

        if (selector(ultimo) == ultimo.pressaoArComprimido.toDouble()) {
          pressaoArComprimido = ultimoValor;
        } else if (selector(ultimo) == ultimo.pressaoCarga.toDouble()) {
          pressaoCarga = ultimoValor;
        } else if (selector(ultimo) == ultimo.pressaoAlivio.toDouble()) {
          pressaoAlivio = ultimoValor;
        }

        ultimaHora = _formatHora(ultimo.dataHora.toString());
      }

      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void startMonitoringEstado() {
    fetchEstadoCompressor();
    _estadoTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => fetchEstadoCompressor(),
    );
  }

  Future<void> fetchEstadoCompressor() async {
    try {
      final dados = await _service.fetchDados();
      mensagemEstado = dados.estado;
      ligado = dados.ligado;
      notifyListeners();
    } catch (e) {
      mensagemEstado = 'Erro';
      setError(e.toString());
    }
  }

  String _formatHora(String dataHora) {
    try {
      return dataHora.substring(11, 19);
    } catch (_) {
      return dataHora;
    }
  }

  void stopFetching() => _timer?.cancel();
  void stopMonitoringEstado() => _estadoTimer?.cancel();

  @override
  void dispose() {
    stopFetching();
    stopMonitoringEstado();
    super.dispose();
  }
}
