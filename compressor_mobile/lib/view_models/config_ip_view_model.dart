part of '_view_model_lib.dart';

class ConfigIPViewModel extends BaseViewModel {
  final ipController = TextEditingController();
  final portAPIController = TextEditingController();

  String? ssid;
  String? localIP;
  String? connectionType;

  Future<void> init() async {
    await _carregarDados();
    await _obterInfoRede();
  }

  Future<void> _carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    ipController.text = prefs.getString('ip') ?? '10.110.18.10';
    portAPIController.text = prefs.getString('portAPI') ?? '9091';
    notifyListeners();
  }

  Future<void> _obterInfoRede() async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      final info = NetworkInfo();

      final ip = await info.getWifiIP();
      final wifiName = await info.getWifiName();

      ssid = wifiName ?? "Desconhecida";
      localIP = ip ?? "Não disponível";

      switch (connectivity) {
        case ConnectivityResult.wifi:
          connectionType = "Wi-Fi";
          break;
        case ConnectivityResult.mobile:
          connectionType = "Dados móveis";
          break;
        case ConnectivityResult.ethernet:
          connectionType = "Ethernet";
          break;
        case ConnectivityResult.bluetooth:
          connectionType = "Bluetooth";
          break;
        case ConnectivityResult.vpn:
          connectionType = "VPN";
          break;
        case ConnectivityResult.other:
          connectionType = "Outro";
          break;
        case ConnectivityResult.none:
        default:
          connectionType = "Sem conexão";
          break;
      }

      notifyListeners();
    } catch (e) {
      setError('Erro ao obter informações da rede: $e');
    }
  }

  String? validarIP(String? value) {
    if (value == null || value.isEmpty) return 'Informe o IP';
    final ipRegex =
        RegExp(r'^(?:(?:25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)(\.|$)){4}$');
    if (!ipRegex.hasMatch(value)) return 'IP inválido';
    return null;
  }

  String? validarPorta(String? value) {
    if (value == null || value.isEmpty) return 'Informe a porta';
    final port = int.tryParse(value);
    if (port == null || port < 1 || port > 65535) return 'Porta inválida';
    return null;
  }

  Future<void> salvarDados() async {
    try {
      setLoading(true);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('ip', ipController.text.trim());
      await prefs.setString('portAPI', portAPIController.text.trim());

      await setupLocator();

      notifyListeners();
    } catch (e) {
      setError('Erro ao salvar configurações: $e');
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    ipController.dispose();
    portAPIController.dispose();
    super.dispose();
  }
}
