part of '_widgets_lib.dart';

class NetworkInfoCard extends StatelessWidget {
  final String? connectionType;
  final String? ssid;
  final String? localIP;

  const NetworkInfoCard({
    super.key,
    this.connectionType,
    this.ssid,
    this.localIP,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3A3A3A),
            Color(0xFF2A2A2A),
            Color(0xFF1E1E1E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(-2, -2),
          ),
        ],
        border: Border.all(
          color: Colors.redAccent.withOpacity(0.6),
          width: 1.4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              children: [
                const Icon(
                  Icons.network_check,
                  color: Colors.redAccent,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  "REDE ATUAL",
                  style: GoogleFonts.orbitron(
                    fontSize: 18,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _buildInfoRow(Icons.wifi, "Conexão", connectionType ?? "-"),
            _buildInfoRow(Icons.router, "SSID", ssid ?? "Desconhecida"),
            _buildInfoRow(Icons.device_unknown, "IP Local", localIP ?? "-"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.redAccent.withOpacity(0.15),
              border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
            ),
            child: Icon(icon, size: 16, color: Colors.redAccent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$label: ",
                style: GoogleFonts.orbitron(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: GoogleFonts.orbitron(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
