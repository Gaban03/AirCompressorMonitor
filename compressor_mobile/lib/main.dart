import 'package:compressor_mobile/services/_services_lib.dart';
import 'package:compressor_mobile/view_models/_view_model_lib.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'app.dart';
import '../src/notification/noti_libs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMsg().initFCM();
  await setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final vm = CompressorDadosViewModel();
          vm.startMonitoringEstado();
          return vm;
        }),
      ],
      child: const App(),
    ),
  );
}
