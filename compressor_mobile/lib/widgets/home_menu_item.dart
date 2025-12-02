part of '_widgets_lib.dart';

class HomeMenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? warning;
  final IconData icon;
  final VoidCallback? onPressed;

  const HomeMenuItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.warning,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;
    final rf = context.rf;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: hp(0.8)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Card(
          color: const Color(0xFF2C2C2C),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFB71C1C), width: 1.2),
          ),
          child: Padding(
            padding: EdgeInsets.all(wp(3.5)),
            child: Row(
              children: [
                // Ícone
                Container(
                  padding: EdgeInsets.all(wp(2.5)),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEF5350), Color(0xFFB71C1C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: rf(22)),
                ),

                SizedBox(width: wp(4)),

                // Textos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title.toUpperCase(),
                              style: GoogleFonts.orbitron(
                                fontSize: rf(15),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          if (warning != null)
                            Row(
                              children: [
                                Icon(Icons.warning_amber_rounded,
                                    color: Colors.amberAccent, size: rf(16)),
                                SizedBox(width: wp(1)),
                                Text(
                                  warning!,
                                  style: GoogleFonts.poppins(
                                    color: Colors.amberAccent,
                                    fontSize: rf(12),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: hp(0.5)),
                      Text(
                        subtitle,
                        style: GoogleFonts.orbitron(
                          color: Colors.white70,
                          fontSize: rf(13),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: wp(4)),

                Icon(Icons.chevron_right, color: Colors.white70, size: rf(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
