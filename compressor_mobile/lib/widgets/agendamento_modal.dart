part of '_widgets_lib.dart';

class AgendamentoModal extends StatelessWidget {
  final AgendamentoViewModel vm;
  final Agendamento? agendamento;
  final VoidCallback onSaved;

  AgendamentoModal({
    super.key,
    required this.vm,
    this.agendamento,
    required this.onSaved,
  });

  TimeOfDay? inicio;
  TimeOfDay? fim;
  List<String>? diasSelecionados;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        // Preenche se estiver editando
        inicio ??= agendamento != null
            ? context.parseTimeString(agendamento!.horaInicio)
            : null;

        fim ??= agendamento != null
            ? context.parseTimeString(agendamento!.horaFim)
            : null;

        diasSelecionados ??= agendamento != null
            ? context.diasEnToPtList(agendamento!.diasSemana)
            : <String>[];

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 26,
            left: 20,
            right: 20,
            top: 26,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TituloModal(
                  texto: agendamento == null
                      ? 'Novo Agendamento'
                      : 'Editar Agendamento',
                ),

                const SizedBox(height: 28),

                // ------ Início ------
                TimeField(
                  label: "Início",
                  hora: inicio,
                  onTap: () async {
                    final t = await context.showTimePickerBR(
                      context: context,
                      initial: inicio ?? TimeOfDay.now(),
                    );
                    if (t != null) setState(() => inicio = t);
                  },
                ),

                const SizedBox(height: 22),

                // ------ Fim ------
                TimeField(
                  label: "Fim",
                  hora: fim,
                  onTap: () async {
                    final t = await context.showTimePickerBR(
                      context: context,
                      initial: fim ?? TimeOfDay.now(),
                    );
                    if (t != null) setState(() => fim = t);
                  },
                ),

                const SizedBox(height: 28),

                // ------ Seleção de dias ------
                DiaSelector(
                  selecionados: diasSelecionados!,
                  onToggle: (d) {
                    setState(() {
                      diasSelecionados!.contains(d)
                          ? diasSelecionados!.remove(d)
                          : diasSelecionados!.add(d);
                    });
                  },
                ),

                const SizedBox(height: 36),

                // ------ Botão salvar ------
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      agendamento == null ? 'Salvar' : 'Atualizar',
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      if (inicio == null || fim == null) return;

                      final novo = Agendamento(
                        id: agendamento?.id,
                        compressorId: agendamento?.compressorId ?? 1,
                        diasSemana: context.diasPtToEnList(diasSelecionados!),
                        horaInicio: context.formatTimeOfDay(inicio!),
                        horaFim: context.formatTimeOfDay(fim!),
                        ativo: agendamento?.ativo ?? true,
                        descricao: agendamento?.descricao,
                      );

                      bool ok = agendamento == null
                          ? await vm.criarAgendamento(novo)
                          : await vm.atualizarAgendamento(
                              agendamento!.id!,
                              novo,
                            );

                      if (ok) {
                        onSaved();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),

                const SizedBox(height: 28),
              ],
            ),
          ),
        );
      },
    );
  }
}
