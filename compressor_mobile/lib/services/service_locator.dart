part of '_services_lib.dart';

final getIt = GetIt.instance;

void setupLocator() {

  const baseUrl = 'http://10.110.18.10:9091/';

  getIt.registerLazySingleton<CompressorService>(
    () => CompressorService(baseUrl: baseUrl),
  );

}
