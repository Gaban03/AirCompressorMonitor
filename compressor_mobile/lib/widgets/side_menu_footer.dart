part of '_widgets_lib.dart';

class SideMenuFooter extends StatelessWidget {
  const SideMenuFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          Text(
            "v2.0.0",
            style: GoogleFonts.poppins(
              color: Colors.white38,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "© 2025 SENAI São Carlos",
            style: GoogleFonts.poppins(
              color: Colors.white24,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
