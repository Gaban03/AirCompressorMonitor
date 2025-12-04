part of '_views_lib.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final List<ScheduleModel> _agendamentos = [];
  final Set<int> _selecionados = {};
  bool _modoSelecao = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton:
          _modoSelecao ? _fabDeleteSelecionados() : _fabAdicionar(),
      body: Content(
        title: "SENAI",
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.hp(2),
            horizontal: context.wp(4),
          ),
          child: Column(
            children: [
              Expanded(
                child: _agendamentos.isEmpty
                    ? _emptyState()
                    : ListView.builder(
                        itemCount: _agendamentos.length,
                        itemBuilder: (_, i) => _buildCard(i),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  //  EMPTY STATE CLEAN
  // --------------------------------------------------------------------------

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.schedule_outlined, color: Colors.white24, size: 70),
        SizedBox(height: 18),
        Text(
          "Nenhum agendamento",
          style: GoogleFonts.orbitron(
            color: Colors.white30,
            fontSize: context.rf(14),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  //  FLOATING BUTTONS
  // --------------------------------------------------------------------------

  Widget _fabAdicionar() {
    return FloatingActionButton(
      backgroundColor: Colors.redAccent,
      child: const Icon(Icons.add, color: Colors.white),
      onPressed: _abrirModalNovoAgendamento,
    );
  }

  Widget _fabDeleteSelecionados() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.delete_outline,
          color: Color.fromARGB(255, 255, 255, 255)),
      label: Text(
        "Excluir (${_selecionados.length})",
        style: GoogleFonts.orbitron(
            color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      onPressed: _removerSelecionados,
    );
  }

  // --------------------------------------------------------------------------
  //  CARD CLEAN E INDUSTRIAL
  // --------------------------------------------------------------------------

  Widget _buildCard(int index) {
    final item = _agendamentos[index];
    final selecionado = _selecionados.contains(index);

    return GestureDetector(
      onLongPress: () {
        setState(() {
          _modoSelecao = true;
          _selecionados.add(index);
        });
      },
      onTap: () {
        if (_modoSelecao) {
          setState(() {
            selecionado
                ? _selecionados.remove(index)
                : _selecionados.add(index);

            if (_selecionados.isEmpty) _modoSelecao = false;
          });
        } else {
          _abrirModalEditarAgendamento(index);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selecionado ? Colors.redAccent : Colors.white12,
            width: selecionado ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Indicador clean
            Container(
              width: 6,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(width: 14),

            // Conteúdo principal
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Compressor ${item.compressor}",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${item.inicio.format(context)} → ${item.fim.format(context)}",
                    style: GoogleFonts.orbitron(
                      color: Colors.redAccent,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    item.dias.join(" · "),
                    style: GoogleFonts.poppins(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Transform.scale(
              scale: 1.15,
              child: Switch(
                value: item.ativado,
                activeColor: Colors.redAccent,
                inactiveThumbColor: Colors.white24,
                onChanged: (_) {
                  setState(() => item.ativado = !item.ativado);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  //  REMOVER SELECIONADOS
  // --------------------------------------------------------------------------

  void _removerSelecionados() {
    setState(() {
      _agendamentos.removeWhere((item) {
        final idx = _agendamentos.indexOf(item);
        return _selecionados.contains(idx);
      });
      _selecionados.clear();
      _modoSelecao = false;
    });
  }

  // --------------------------------------------------------------------------
  //  MODAL REFINADO, CLEAN E COM SELETOR DE COMPRESSOR
  // --------------------------------------------------------------------------

  TimeOfDay? inicio;
  TimeOfDay? fim;
  int compressorSelecionado = 1;
  List<String> diasSelecionados = [];

  void _abrirModalEditarAgendamento(int index) {
    final ag = _agendamentos[index];

    inicio = ag.inicio;
    fim = ag.fim;
    compressorSelecionado = ag.compressor;
    diasSelecionados = List.from(ag.dias);

    _abrirModalNovoAgendamento(editIndex: index);
  }

  void _abrirModalNovoAgendamento({int? editIndex}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF101010),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateModal) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              context.wp(6),
              context.hp(3),
              context.wp(6),
              MediaQuery.of(context).viewInsets.bottom + context.hp(3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  editIndex == null ? "Novo Agendamento" : "Editar Agendamento",
                  style: GoogleFonts.orbitron(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 26),

                // Compressor Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _chipCompressor(
                      id: 1,
                      selecionado: compressorSelecionado == 1,
                      onTap: () =>
                          setStateModal(() => compressorSelecionado = 1),
                    ),
                    SizedBox(width: 12),
                    _chipCompressor(
                      id: 2,
                      selecionado: compressorSelecionado == 2,
                      onTap: () =>
                          setStateModal(() => compressorSelecionado = 2),
                    ),
                  ],
                ),

                SizedBox(height: 22),

                _campoHoraModal(
                  label: "Início",
                  hora: inicio,
                  onTap: () async {
                    final t = await showTimePicker(
                      context: context,
                      builder: _temaTimePicker,
                      initialTime: inicio ?? TimeOfDay.now(),
                    );
                    if (t != null) setStateModal(() => inicio = t);
                  },
                ),
                SizedBox(height: 12),

                _campoHoraModal(
                  label: "Fim",
                  hora: fim,
                  onTap: () async {
                    final t = await showTimePicker(
                      context: context,
                      builder: _temaTimePicker,
                      initialTime: fim ?? TimeOfDay.now(),
                    );
                    if (t != null) setStateModal(() => fim = t);
                  },
                ),

                SizedBox(height: 26),

                _chipsDias(setStateModal),

                SizedBox(height: 28),

                _botaoSalvar(editIndex),
              ],
            ),
          );
        },
      ),
    );
  }

  // CHIP DE COMPRESSOR (CLEAN)
  Widget _chipCompressor({
    required int id,
    required bool selecionado,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
        decoration: BoxDecoration(
          color: selecionado ? Colors.redAccent : Colors.white12,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selecionado ? Colors.redAccent : Colors.white24,
          ),
        ),
        child: Text(
          "Compressor $id",
          style: GoogleFonts.orbitron(
            color: selecionado ? Colors.black : Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Campo hora estilizado
  Widget _campoHoraModal({
    required String label,
    required TimeOfDay? hora,
    required Function() onTap,
  }) {
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
          "$label: ${hora?.format(context) ?? "--:--"}",
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _temaTimePicker(BuildContext context, Widget? child) {
    return Theme(
      data: ThemeData.dark().copyWith(
        timePickerTheme: const TimePickerThemeData(
          dialHandColor: Colors.redAccent,
          dialBackgroundColor: Colors.black,
        ),
      ),
      child: child!,
    );
  }

  // Chips dos dias
  Widget _chipsDias(Function setModalState) {
    return Wrap(
      spacing: 8,
      children: diasSemana.map((d) {
        final sel = diasSelecionados.contains(d);

        return ChoiceChip(
          label: Text(
            d,
            style:
                GoogleFonts.poppins(color: sel ? Colors.white : Colors.black),
          ),
          selected: sel,
          selectedColor: Colors.redAccent,
          backgroundColor: Colors.white10,
          onSelected: (_) {
            setModalState(() {
              sel ? diasSelecionados.remove(d) : diasSelecionados.add(d);
            });
          },
        );
      }).toList(),
    );
  }

  Widget _botaoSalvar(int? editIndex) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: () {
        if (inicio != null && fim != null) {
          setState(() {
            if (editIndex == null) {
              _agendamentos.add(ScheduleModel(
                compressor: compressorSelecionado,
                inicio: inicio!,
                fim: fim!,
                dias: List.from(diasSelecionados),
              ));
            } else {
              _agendamentos[editIndex] = ScheduleModel(
                compressor: compressorSelecionado,
                inicio: inicio!,
                fim: fim!,
                dias: List.from(diasSelecionados),
                ativado: _agendamentos[editIndex].ativado,
              );
            }
          });

          Navigator.pop(context);
        }
      },
      child: Text(
        editIndex == null ? "Salvar" : "Atualizar",
        style: GoogleFonts.orbitron(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// MODEL
// -----------------------------------------------------------------------------

class ScheduleModel {
  int compressor;
  TimeOfDay inicio;
  TimeOfDay fim;
  List<String> dias;
  bool ativado;

  ScheduleModel({
    required this.compressor,
    required this.inicio,
    required this.fim,
    required this.dias,
    this.ativado = true,
  });
}

const diasSemana = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"];
