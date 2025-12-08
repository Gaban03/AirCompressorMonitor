part of '_widgets_lib.dart';

class AgendamentoCard extends StatelessWidget {
  final Agendamento item;
  final bool selecionado;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Function(bool ativo) onToggleAtivo;

  const AgendamentoCard({
    super.key,
    required this.item,
    required this.selecionado,
    required this.onTap,
    required this.onLongPress,
    required this.onToggleAtivo,
  });

  @override
  Widget build(BuildContext context) {
    final diasPT = item.diasSemana.map((d) => diasENtoPT[d] ?? d).toList();

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selecionado ? Colors.white12 : Colors.white10,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selecionado ? Colors.redAccent : Colors.white12,
            width: 1.4,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: diasPT
                        .map((d) => AgendamentoDiaChip(label: d))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${item.horaInicio} → ${item.horaFim}",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: item.ativo,
              onChanged: onToggleAtivo,
              activeColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
