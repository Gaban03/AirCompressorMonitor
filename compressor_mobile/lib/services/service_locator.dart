part of '_services_lib.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();

  final ip = prefs.getString('ip') ?? '10.110.18.10';
  final port = prefs.getString('portAPI') ?? '9091';

  final baseUrl = 'http://$ip:$port/';

  if (GetIt.I.isRegistered<CompressorService>()) {
    GetIt.I.unregister<CompressorService>();
  }

  getIt.registerLazySingleton<CompressorService>(
    () => CompressorService(baseUrl: baseUrl),
  );
}

