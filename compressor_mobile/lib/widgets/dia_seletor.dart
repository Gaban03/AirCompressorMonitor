part of "_widgets_lib.dart";

class DiaSelector extends StatelessWidget {
  final List<String> selecionados;
  final Function(String dia) onToggle;

  const DiaSelector({
    super.key,
    required this.selecionados,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: diasPTBR.map((d) {
        final bool ativo = selecionados.contains(d);

        return ChoiceChip(
          label: Text(
            d,
            style: GoogleFonts.poppins(
              color: ativo ? Colors.white : Colors.black,
            ),
          ),
          selected: ativo,
          selectedColor: Colors.redAccent,
          backgroundColor: Colors.white10,
          onSelected: (_) => onToggle(d),
        );
      }).toList(),
    );
  }
}
