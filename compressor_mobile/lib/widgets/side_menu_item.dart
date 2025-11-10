part of '_widgets_lib.dart';

class SideMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const SideMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 200), onTap);
      },
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.white12,
      highlightColor: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            FaIcon(icon, color: color ?? Colors.white70, size: 18),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: color ?? Colors.white.withOpacity(0.95),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
