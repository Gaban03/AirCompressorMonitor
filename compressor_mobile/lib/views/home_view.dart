part of '_views_lib.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<bool> _onWillPop() async {
    if (Navigator.of(context).canPop()) return true;

    final shouldExit = await DialogAction.show(
      context: context,
      title: "Sair do aplicativo?",
      content: "Deseja realmente fechar o app?",
      icon: Icons.exit_to_app_rounded,
      iconColor: Colors.redAccent,
      confirmText: "Sair",
      cancelText: "Cancelar",
      confirmColor: Colors.redAccent,
      cancelColor: Colors.grey,
    );
    return shouldExit;
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;
    final rf = context.rf;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Content(
          title: "SENAI",
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: hp(1),
              horizontal: wp(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: hp(2)),
                  child: Text(
                    "Serviços Disponíveis",
                    style: GoogleFonts.orbitron(
                      fontSize: rf(24),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),

                HomeMenuItem(
                  title: "Controle do compressor",
                  subtitle: "Liga e desliga o compressor",
                  icon: Icons.control_point_rounded,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CompressorControl()),
                  ),
                ),

                HomeMenuItem(
                  title: "Horas de funcionamento",
                  subtitle:
                      "Indica tempo de trabalho e tempo total do maquinário",
                  icon: Icons.access_time_rounded,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CompressorHorasView()),
                  ),
                ),

                HomeMenuItem(
                  title: "Temp. Ambiente",
                  subtitle: "Dados da temperatura ambiente",
                  icon: Icons.thermostat,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TemperatureView(
                        titulo: "Temp. Ambiente",
                        tipo: TipoTemperatura.ambiente,
                        color: Colors.redAccent,
                        minY: 0,
                        maxY: 90,
                      ),
                    ),
                  ),
                ),

                HomeMenuItem(
                  title: "Temp. Ar Comprimido",
                  subtitle: "Temperatura do ar comprimido",
                  icon: Icons.thermostat,
                  onPressed: () => Navigator.push(
                    context,
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TemperatureView(
                        titulo: "Temp. Orvalho",
                        tipo: TipoTemperatura.orvalho,
                        color: Colors.redAccent,
                        minY: 0,
                        maxY: 45,
                      ),
                    ),
                  ),
                ),

                HomeMenuItem(
                  title: "Temp. Óleo",
                  subtitle: "Dados da temperatura do óleo",
                  icon: Icons.thermostat,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TemperatureView(
                        titulo: "Temp. Óleo",
                        tipo: TipoTemperatura.oleo,
                        color: Colors.redAccent,
                        minY: 0,
                        maxY: 150,
                      ),
                    ),
                  ),
                ),

                HomeMenuItem(
                  title: "Pressão Ar Comprimido",
                  subtitle: "Dados da pressão do ar comprimido",
                  icon: Icons.speed,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PressureView(
                        titulo: "Pressão Ar Comprimido",
                        tipo: TipoPressao.arComprimido,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                // HomeMenuItem(
                //   title: "Pressão de Carga",
                //   subtitle: "Dados da pressão de carga",
                //   icon: Icons.compress,
                //   onPressed: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (_) => const PressureView(
                //         titulo: "Pressão de Carga",
                //         tipo: TipoPressao.carga,
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ),
                // ),

                // HomeMenuItem(
                //   title: "Pressão de Alívio",
                //   subtitle: "Dados da pressão de alívio",
                //   icon: Icons.air,
                //   onPressed: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (_) => const PressureView(
                //         titulo: "Pressão de Alívio",
                //         tipo: TipoPressao.alivio,
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
