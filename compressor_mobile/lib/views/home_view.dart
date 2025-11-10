part of '_views_lib.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Content(
        title: "SENAI",
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Text(
                  "Serviços Disponíveis",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 182, 182, 182),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              HomeMenuItem(
                title: "Temp. Ambiente",
                subtitle: "Dados da temperatura ambiente do compressor",
                icon: Icons.thermostat,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const TemperatureView(
                      titulo: "Temp. Ambiente",
                      tipo: TipoTemperatura.ambiente,
                      color: Colors.redAccent,
                      minY: 0,
                      maxY: 35,
                    ),
                  ),
                ),
              ),
              HomeMenuItem(
                title: "Temp. Ar Comprimido",
                subtitle: "Dados da temperatura do ar comprimido do compressor",
                icon: Icons.thermostat,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const TemperatureView(
                      titulo: "Temp. Ar Comprimido",
                      tipo: TipoTemperatura.arComprimido,
                      color: Colors.redAccent,
                      minY: 0,
                      maxY: 90,
                    ),
                  ),
                ),
              ),
              HomeMenuItem(
                title: "Temp. Orvalho",
                subtitle: "Dados da temperatura de orvalho",
                icon: Icons.thermostat,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const TemperatureView(
                      titulo: "Temp. Orvalho",
                      tipo: TipoTemperatura.orvalho,
                      color: Colors.redAccent,
                      minY: 0,
                      maxY: 15,
                    ),
                  ),
                ),
              ),
              HomeMenuItem(
                title: "Temp. Óleo",
                subtitle: "Dados da temperatura do óleo do compressor",
                icon: Icons.thermostat,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const TemperatureView(
                      titulo: "Temp. Óleo",
                      tipo: TipoTemperatura.oleo,
                      color: Colors.redAccent,
                      minY: 0,
                      maxY: 80,
                    ),
                  ),
                ),
              ),
              HomeMenuItem(
                title: "Controle do compressor",
                subtitle: "Liga e desliga o compressor",
                icon: Icons.control_point_rounded,
                onPressed: () async {
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const CompressorControl()));
                  }
                },
              ),
              HomeMenuItem(
                title: "Pressão Ar Comprimido",
                subtitle: "Dados da pressão do ar comprimido",
                icon: Icons.speed,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const PressureView(
                      titulo: "Pressão Ar Comprimido",
                      tipo: TipoPressao.arComprimido,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              HomeMenuItem(
                title: "Pressão de Carga",
                subtitle: "Dados da pressão de carga do compressor",
                icon: Icons.compress,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const PressureView(
                      titulo: "Pressão de Carga",
                      tipo: TipoPressao.carga,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              HomeMenuItem(
                title: "Pressão de Alívio",
                subtitle: "Dados da pressão de alívio do compressor",
                icon: Icons.air,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const PressureView(
                      titulo: "Pressão de Alívio",
                      tipo: TipoPressao.alivio,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
