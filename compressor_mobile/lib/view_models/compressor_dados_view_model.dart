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

  String dataHora = '';
  double tempo = 0;
  String mensagemEstado = 'Carregando...';
  bool ligado = false;

  double minY = 0;
  double maxY = 100;

  Timer? _timer;
  Timer? _estadoTimer;

  void startTemperature(TipoTemperatura tipo) {
    stopFetching();
    temperaturaSpots = [];
    labels = [];
    tempo = 0;

    switch (tipo) {
      case TipoTemperatura.ambiente:
        minY = 0;
        maxY = 35;
        fetchDadosRoomTemperature();
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => fetchDadosRoomTemperature(),
        );
        break;

      case TipoTemperatura.arComprimido:
        minY = 0;
        maxY = 90;
        fetchDadosCompressedAirTemperature();
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => fetchDadosCompressedAirTemperature(),
        );
        break;

      case TipoTemperatura.orvalho:
        minY = 0;
        maxY = 15;
        fetchDadosDewTemperature();
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => fetchDadosDewTemperature(),
        );
        break;

      case TipoTemperatura.oleo:
        minY = 0;
        maxY = 80;
        fetchDadosOilTemperature();
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => fetchDadosOilTemperature(),
        );
        break;
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
        fetchDadosCompressedAirPressure();
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => fetchDadosCompressedAirPressure(),
        );
        break;

      case TipoPressao.carga:
        minY = 0;
        maxY = 8;
        fetchDadosPressureLoad();
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => fetchDadosPressureLoad(),
        );
        break;

      case TipoPressao.alivio:
        minY = 0;
        maxY = 12;
        fetchDadosPressureRelief();
        _timer = Timer.periodic(
          const Duration(seconds: 20),
          (_) => fetchDadosPressureRelief(),
        );
        break;
    }
  }

  void startMonitoringEstado() {
    fetchEstadoCompressor();
    _estadoTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => fetchEstadoCompressor(),
    );
  }

  void stopFetching() => _timer?.cancel();
  void stopMonitoringEstado() => _estadoTimer?.cancel();

  Future<void> fetchDadosRoomTemperature() async => _fetchData(
        () async {
          final d = await _service.fetchDados();
          return d.temperaturaAmbiente.toDouble();
        },
        (v) => temperaturaAmbiente = v,
        temperaturaSpots,
      );

  Future<void> fetchDadosCompressedAirTemperature() async => _fetchData(
        () async {
          final d = await _service.fetchDados();
          return d.temperaturaArComprimido.toDouble();
        },
        (v) => temperaturaArComprimido = v,
        temperaturaSpots,
      );

  Future<void> fetchDadosDewTemperature() async => _fetchData(
        () async {
          final d = await _service.fetchDados();
          return d.temperaturaOrvalho.toDouble();
        },
        (v) => temperaturaOrvalho = v,
        temperaturaSpots,
      );

  Future<void> fetchDadosOilTemperature() async => _fetchData(
        () async {
          final d = await _service.fetchDados();
          return d.temperaturaOleo.toDouble();
        },
        (v) => temperaturaOleo = v,
        temperaturaSpots,
      );

  Future<void> fetchDadosCompressedAirPressure() async => _fetchData(
        () async {
          final d = await _service.fetchDados();
          return d.pressaoArComprimido.toDouble();
        },
        (v) => pressaoArComprimido = v,
        pressaoSpots,
      );

  Future<void> fetchDadosPressureLoad() async => _fetchData(
        () async {
          final d = await _service.fetchDados();
          return d.pressaoCarga.toDouble();
        },
        (v) => pressaoCarga = v,
        pressaoSpots,
      );

  Future<void> fetchDadosPressureRelief() async => _fetchData(
        () async {
          final d = await _service.fetchDados();
          return d.pressaoAlivio.toDouble();
        },
        (v) => pressaoAlivio = v,
        pressaoSpots,
      );

  Future<void> fetchEstadoCompressor() async {
    try {
      clearError();
      final dados = await _service.fetchDados();
      mensagemEstado = dados.estado;
      ligado = dados.ligado;
      notifyListeners();
    } catch (e) {
      mensagemEstado = 'Erro';
      setError(e.toString());
      notifyListeners();
    }
  }

  Future<void> _fetchData(
    Future<double> Function() getValue,
    void Function(double) setValue,
    List<FlSpot> targetSpots,
  ) async {
    try {
      setLoading(true);
      clearError();

      final value = await getValue();
      setValue(value);
      tempo += 1;

      final newSpots = List<FlSpot>.from(targetSpots)
        ..add(FlSpot(tempo, value));
      final newLabels = List<String>.from(labels)
        ..add(_formatHora(DateTime.now().toString()));

      if (newSpots.length > maxPoints) {
        newSpots.removeAt(0);
        newLabels.removeAt(0);
      }

      if (targetSpots == temperaturaSpots) {
        temperaturaSpots = newSpots;
      } else {
        pressaoSpots = newSpots;
      }

      labels = newLabels;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  String _formatHora(String dataHora) {
    try {
      if (dataHora.length >= 19) return dataHora.substring(11, 19);
      return dataHora;
    } catch (_) {
      return dataHora;
    }
  }

  @override
  void dispose() {
    stopFetching();
    stopMonitoringEstado();
    super.dispose();
  }
}
