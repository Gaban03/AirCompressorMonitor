part of '_widgets_lib.dart';

class TimeField extends StatelessWidget {
  final String label;
  final TimeOfDay? hora;
  final VoidCallback onTap;

  const TimeField({
    super.key,
    required this.label,
    required this.hora,
    required this.onTap,
  });

  String formatTimePTBR(BuildContext context, TimeOfDay? time) {
    if (time == null) return "--:--";
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return "$hours:$minutes";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white24),
        ),
        child: Text(
          "$label: ${formatTimePTBR(context, hora)}",
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
