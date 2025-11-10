part of '_views_lib.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Content(
        title: "SENAI",
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SectionTitle("Rede"),
            _buildConfigTile(
              title: "Configurar IP",
              icon: Icons.language,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ConfigIpView()),
              ),
            ),
            const SizedBox(height: 15),
            const SectionTitle("Sistema"),
            _buildConfigTile(
              title: "Sobre o dispositivo",
              icon: Icons.info_outline,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutDispositiveView()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(14),
          border:
              Border.all(color: Colors.redAccent.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: Colors.redAccent, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white54, size: 22),
          ],
        ),
      ),
    );
  }
}
