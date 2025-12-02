part of '_widgets_lib.dart';

class FalhaCard extends StatelessWidget {
  final CompressorFalhasDto falha;

  const FalhaCard({super.key, required this.falha});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Falha #${falha.id}",
                style: GoogleFonts.orbitron(
                  fontSize: 16,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.error, color: Colors.redAccent, size: 22),
            ],
          ),

          const SizedBox(height: 12),

          // Descrição
          Text(
            falha.descricao,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 14),

          // Data e hora
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: Colors.white38),
              const SizedBox(width: 6),
              Text(
                falha.dataHoraFormatada,
                style: GoogleFonts.orbitron(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
