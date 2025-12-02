part of '_views_lib.dart';

class CompressorHorasView extends StatefulWidget {
  const CompressorHorasView({super.key});

  @override
  State<CompressorHorasView> createState() => _CompressorHorasViewState();
}

class _CompressorHorasViewState extends State<CompressorHorasView> {
  late final CompressorDadosViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = CompressorDadosViewModel();
    vm.fetchEstadoCompressor();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Content(
        title: "SENAI",
        body: AnimatedBuilder(
          animation: vm,
          builder: (_, __) {
            if (vm.isLoading && vm.horaTotal == 0 && vm.horaCarga == 0) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: context.hp(2.5),
                horizontal: context.wp(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.hp(3)),

                  // CARD HORA CARGA
                  _buildHourCard(
                    context,
                    label: "Hora carga",
                    value: vm.horaCarga,
                    icon: Icons.bolt,
                    color: Colors.orangeAccent,
                  ),

                  SizedBox(height: context.hp(2.5)),

                  // CARD HORA TOTAL
                  _buildHourCard(
                    context,
                    label: "Hora total",
                    value: vm.horaTotal,
                    icon: Icons.timer_rounded,
                    color: Colors.blueAccent,
                  ),

                  SizedBox(height: context.hp(3)),

                  // ================================
                  //      CARD INFORMATIVO MELHORADO
                  // ================================
                  Container(
                    padding: EdgeInsets.all(context.wp(4)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(context.wp(4)),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1F1F1F),
                          Color(0xFF121212),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: Colors.white10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.25),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Colors.blueAccent,
                              size: context.rf(22),
                            ),
                            SizedBox(width: context.wp(2)),
                            Text(
                              "INFORMATIVO",
                              style: GoogleFonts.orbitron(
                                color: Colors.blueAccent,
                                fontSize: context.rf(14),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.hp(1.8)),
                        Text(
                          "As informações sobre manutenções preventivas deste compressor "
                          "estão detalhadas no manual oficial do fabricante.",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.orbitron(
                              color: Colors.white,
                              fontSize: context.rf(12.5),
                              letterSpacing: 2.0,
                              height: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: context.hp(2)),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: context.hp(1.2),
                            horizontal: context.wp(3),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(context.wp(3)),
                            color: Colors.blueAccent.withOpacity(0.1),
                            border: Border.all(
                              color: Colors.blueAccent.withOpacity(0.4),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.link_rounded,
                                color: Colors.blueAccent,
                                size: context.rf(20),
                              ),
                              SizedBox(width: context.wp(3)),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "https://www.metalplan.com.br/manuais-e-prontuarios/"));
                                  },
                                  child: Text(
                                    "Acessar site do fabricante",
                                    style: GoogleFonts.orbitron(
                                      color: Colors.blueAccent,
                                      fontSize: context.rf(12.5),
                                      decoration: TextDecoration.underline,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.hp(3)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHourCard(
    BuildContext context, {
    required String label,
    required double value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LABEL
        Container(
          padding: EdgeInsets.symmetric(
            vertical: context.hp(0.5),
            horizontal: context.wp(3),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.wp(3)),
            border: Border.all(color: color, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.35),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ],
          ),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.orbitron(
              color: color,
              fontSize: context.rf(11),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),

        SizedBox(height: context.hp(1)),

        Container(
          padding: EdgeInsets.symmetric(
            vertical: context.hp(2),
            horizontal: context.wp(6),
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2B2B2B), Color(0xFF1A1A1A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(context.wp(4)),
            border: Border.all(color: Colors.white12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.25),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, size: context.rf(32), color: color),
              SizedBox(width: context.wp(4)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${value.toStringAsFixed(0)} h",
                    style: GoogleFonts.orbitron(
                      color: color,
                      fontSize: context.rf(26),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: context.hp(0.5)),
                  Container(
                    height: 2,
                    width: context.wp(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withOpacity(0.8),
                          color.withOpacity(0.1)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
