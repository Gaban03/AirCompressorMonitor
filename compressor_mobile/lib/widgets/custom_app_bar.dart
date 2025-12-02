part of "_widgets_lib.dart";

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onNotificationsTap;
  final int notificationCount;

  @override
  final Size preferredSize;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onNotificationsTap,
    this.notificationCount = 0,
    this.preferredSize = const Size.fromHeight(95),
  });

  Color _getEstadoColor(String estado) {
    switch (estado.toUpperCase()) {
      case 'DESLIGADO':
        return Colors.grey;
      case 'PARTINDO':
        return Colors.orangeAccent;
      case 'ALIVIO':
        return Colors.blueAccent;
      case 'EMCARGA':
        return Colors.greenAccent;
      case 'STANDBY':
        return Colors.amberAccent;
      case 'PARANDO':
        return Colors.deepOrangeAccent;
      case 'DESCONHECIDO':
      default:
        return Colors.white;
    }
  }

  String _formatarEstado(String estado) {
    if (estado.isEmpty) return 'CARREGANDO...';
    return estado[0].toUpperCase() + estado.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CompressorDadosViewModel>(context, listen: true);

    final estadoRaw =
        vm.mensagemEstado.isNotEmpty ? vm.mensagemEstado : 'CARREGANDO...';
    final estado = _formatarEstado(estadoRaw);
    final estadoColor = _getEstadoColor(estadoRaw);

    return Material(
      color: Colors.transparent,
      elevation: 14,
      shadowColor: Colors.black.withOpacity(0.5),
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3B3B3B),
              Color(0xFF2B2B2B),
              Color(0xFF1E1E1E),
            ],
          ),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(-2, -2),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 12,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 🔹 Botão Menu
                Builder(
                  builder: (context) => IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.bars,
                      color: Colors.white,
                      size: 22,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    tooltip: 'Menu',
                  ),
                ),

                // 🔹 Título e Estado
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: GoogleFonts.orbitron(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1.8,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: estadoColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: estadoColor, width: 1.1),
                          boxShadow: [
                            BoxShadow(
                              color: estadoColor.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: estadoColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: estadoColor.withOpacity(0.8),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              estado,
                              style: GoogleFonts.poppins(
                                color: estadoColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.warning,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CompressorFalhasView()),
                      ),
                      tooltip: 'Falhas',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
