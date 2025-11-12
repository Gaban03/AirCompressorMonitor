part of '_views_lib.dart';

class DeveloperProfilePage extends StatefulWidget {
  final Developer developer;

  const DeveloperProfilePage({
    super.key,
    required this.developer,
  });

  @override
  State<DeveloperProfilePage> createState() => _DeveloperProfilePageState();
}

class _DeveloperProfilePageState extends State<DeveloperProfilePage> {
  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const About()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final dev = widget.developer;
    final red = Colors.redAccent;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Content(
          title: 'SENAI',
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: red, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: red.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    image: dev.fotoUrl != null
                        ? DecorationImage(
                            image: dev.fotoUrl!.startsWith('http')
                                ? NetworkImage(dev.fotoUrl!)
                                : AssetImage(dev.fotoUrl!) as ImageProvider,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: dev.fotoUrl == null
                      ? Text(
                          dev.nome.substring(0, 1),
                          style: GoogleFonts.orbitron(
                            fontSize: 58,
                            fontWeight: FontWeight.bold,
                            color: red,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 24),
                Text(
                  dev.nome,
                  style: GoogleFonts.orbitron(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  dev.cargo,
                  style: GoogleFonts.openSans(
                    fontSize: 15,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                _infoCard(
                  icon: Icons.email_rounded,
                  label: dev.email,
                  color: red,
                ),
                const SizedBox(height: 14),
                _infoCard(
                  icon: Icons.phone_rounded,
                  label: dev.telefone,
                  color: red,
                ),
                const SizedBox(height: 40),
                if ((dev.githubUrl?.isNotEmpty ?? false) ||
                    (dev.linkedinUrl?.isNotEmpty ?? false))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (dev.githubUrl != null && dev.githubUrl!.isNotEmpty)
                        _socialButton(
                          assetPath: 'assets/images/github.png',
                          url: dev.githubUrl!,
                          tooltip: 'GitHub',
                        ),
                      if (dev.linkedinUrl != null &&
                          dev.linkedinUrl!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: _socialButton(
                            assetPath: 'assets/images/linkedin.png',
                            url: dev.linkedinUrl!,
                            tooltip: 'LinkedIn',
                          ),
                        ),
                    ],
                  ),
                const SizedBox(height: 60),
                Text(
                  "© 2025 - SENAI São Carlos",
                  style: GoogleFonts.openSans(
                    color: Colors.white38,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.openSans(
                fontSize: 15,
                color: Colors.white70,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButton({
    required String assetPath,
    required String url,
    required String tooltip,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () => launchUrlString(url),
      child: Tooltip(
        message: tooltip,
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.9),
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: const TextStyle(color: Colors.white),
        child: SizedBox(
          width: 60,
          height: 60,
          child: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(assetPath, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
