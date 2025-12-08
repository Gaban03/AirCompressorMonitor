part of '_widgets_lib.dart';

class TituloModal extends StatelessWidget {
  final String texto;

  const TituloModal({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: GoogleFonts.orbitron(
        color: Colors.redAccent,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
