part of '_views_lib.dart';

class CompressorControl extends StatefulWidget {
  const CompressorControl({super.key});

  @override
  State<CompressorControl> createState() => _CompressorControlState();
}

class _CompressorControlState extends State<CompressorControl> {
  late final CompressorControlViewModel vm = CompressorControlViewModel();

  @override
  void initState() {
    super.initState();
    vm.carregarEstadoInicial();
    vm.startMonitoringStatus();
  }

  @override
  void dispose() {
    vm.stopMonitoringStatus();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<CompressorControlViewModel>(
        builder: (context, vm, _) {
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              backgroundColor: const Color(0xFF121212),
              body: Content(
                title: "SENAI",
                body: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.04),
                      Text(
                        "Controle do Compressor",
                        style: GoogleFonts.orbitron(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        vm.dataEstado != null
                            ? 'Última atualização: ${vm.dataEstado}'
                            : 'Obtendo status...',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 50),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: vm.ligado
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFD32F2F),
                                    Color(0xFF8B0000)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : LinearGradient(
                                  colors: [
                                    Colors.grey.shade700,
                                    Colors.grey.shade900,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                          boxShadow: vm.ligado
                              ? [
                                  BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.6),
                                    blurRadius: 25,
                                    spreadRadius: 6,
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                  ),
                                ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              vm.ligado
                                  ? Icons.power_settings_new
                                  : Icons.power_off,
                              size: 100,
                              color: Colors.white,
                            ),
                            if (vm.isLoading)
                              const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        vm.ligado
                            ? 'Compressor ligado'
                            : 'Compressor desligado',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: vm.ligado ? Colors.redAccent : Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 45),
                      SizedBox(
                        width: screenWidth * 0.6,
                        height: 58,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: vm.ligado
                                ? const Color(0xFFD32F2F)
                                : const Color(0xFF2E7D32),
                            elevation: 10,
                            shadowColor: Colors.black54,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: vm.isLoading
                              ? null
                              : () async {
                                  await vm.toggleCompressor();

                                  if (context.mounted) {
                                    AppSnackBar.show(
                                      context,
                                      message: vm.ligado
                                          ? "Compressor ligado com sucesso!"
                                          : "Compressor desligado com sucesso!",
                                      type: vm.ligado
                                          ? SnackType.success
                                          : SnackType.error,
                                    );
                                  }
                                },
                          child: vm.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                )
                              : Text(
                                  vm.ligado ? 'Desligar' : 'Ligar',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      if (vm.hasError)
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            vm.errorMessage ?? 'Erro desconhecido',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.redAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
