part of '_widgets_lib.dart';

class StatCard extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final Color color;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final rf = context.rf;
    final hp = context.hp;
    final wp = context.wp;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: hp(1.5),
        horizontal: wp(3),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.6), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: rf(12),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: hp(0.8)),
          Text(
            '${value.toStringAsFixed(1)} $unit',
            style: GoogleFonts.orbitron(
              color: color,
              fontSize: rf(18),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
