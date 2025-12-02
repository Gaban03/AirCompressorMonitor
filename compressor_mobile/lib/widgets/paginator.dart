part of '_widgets_lib.dart';

class Paginator extends StatelessWidget {
  final int page;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final VoidCallback onFirst;
  final VoidCallback onLast;

  const Paginator({
    super.key,
    required this.page,
    required this.totalPages,
    required this.onNext,
    required this.onPrev,
    required this.onFirst,
    required this.onLast,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFirst = page == 0;
    final bool isLast = page + 1 >= totalPages;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 18, top: 25, left: 16, right: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1A1A1A),
            Color(0xFF121212),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white12,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.25),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navButton(
            icon: Icons.first_page,
            enabled: !isFirst,
            onTap: onFirst,
          ),

          _navButton(
            icon: Icons.chevron_left,
            enabled: !isFirst,
            onTap: onPrev,
          ),

          // Texto central
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Página ${page + 1} / $totalPages",
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),

          _navButton(
            icon: Icons.chevron_right,
            enabled: !isLast,
            onTap: onNext,
          ),

          _navButton(
            icon: Icons.last_page,
            enabled: !isLast,
            onTap: onLast,
          ),
        ],
      ),
    );
  }

  Widget _navButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: enabled ? 1 : 0.3,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: enabled ? onTap : null,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: enabled ? Colors.white.withOpacity(0.06) : Colors.white12,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white, // agora é BRANCO puro
            size: 22,
          ),
        ),
      ),
    );
  }
}
