part of '_views_lib.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  late final AgendamentoViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = AgendamentoViewModel();
    vm.carregarAgendamentos();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: AnimatedBuilder(
        animation: vm,
        builder: (_, __) {
          final count = vm.selecionados.length;
          return count > 0 ? _fabDeleteSelecionados(count) : _fabAdicionar();
        },
      ),
      body: Content(
        title: "SENAI",
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.hp(2), horizontal: context.wp(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(Icons.schedule, color: Colors.redAccent, size: 25),
                  const SizedBox(width: 10),
                  Text(
                    "Agendamentos",
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: AnimatedBuilder(
                  animation: vm,
                  builder: (_, __) {
                    if (vm.isLoading && vm.agendamentos.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (vm.errorMessage != null && vm.agendamentos.isEmpty) {
                      return Center(
                        child: Text(
                          vm.errorMessage!,
                          style: GoogleFonts.orbitron(color: Colors.redAccent),
                        ),
                      );
                    }

                    if (vm.agendamentos.isEmpty) {
                      return _emptyState();
                    }

                    return RefreshIndicator(
                      onRefresh: vm.carregarAgendamentos,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        itemCount: vm.agendamentos.length,
                        itemBuilder: (context, i) {
                          final item = vm.agendamentos[i];
                          final selecionado = item.id != null &&
                              vm.selecionados.contains(item.id);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: AgendamentoCard(
                              item: item,
                              selecionado: selecionado ?? false,
                              onTap: () => _onTapItem(item),
                              onLongPress: () => _onLongPressItem(item),
                              onToggleAtivo: (novo) =>
                                  _onToggleAtivo(item, novo),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.schedule_outlined, color: Colors.white24, size: 70),
        const SizedBox(height: 18),
        Text(
          "Nenhum agendamento",
          style: GoogleFonts.orbitron(
              color: Colors.white30, fontSize: context.rf(14)),
        ),
      ],
    );
  }

  Widget _fabAdicionar() {
    return FloatingActionButton(
      backgroundColor: Colors.redAccent,
      child: const Icon(Icons.add, color: Colors.white),
      onPressed: _abrirModalNovoAgendamento,
    );
  }

  Widget _fabDeleteSelecionados(int count) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.delete_outline, color: Colors.white),
      label: Text("Excluir ($count)",
          style: GoogleFonts.orbitron(color: Colors.white)),
      onPressed: _confirmarExcluirSelecionados,
    );
  }

  void _onTapItem(Agendamento item) {
    if (vm.selecionados.isNotEmpty) {
      if (item.id != null) vm.alternarSelecao(item.id!);
    } else {
      _abrirModalEditarAgendamento(item);
    }
  }

  void _onLongPressItem(Agendamento item) {
    if (item.id != null) vm.alternarSelecao(item.id!);
  }

  void _onToggleAtivo(Agendamento item, bool novo) {
    if (item.id == null) return;
    vm.alterarStatus(item.id!, novo);
  }

  void _abrirModalNovoAgendamento() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF101010),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
      isScrollControlled: true,
      builder: (_) => AgendamentoModal(
        vm: vm,
        onSaved: () {
          vm.carregarAgendamentos();
        },
      ),
    );
  }

  void _abrirModalEditarAgendamento(Agendamento item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF101010),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
      isScrollControlled: true,
      builder: (_) => AgendamentoModal(
        vm: vm,
        agendamento: item,
        onSaved: () => vm.carregarAgendamentos(),
      ),
    );
  }

  Future<void> _confirmarExcluirSelecionados() async {
    if (vm.selecionados.isEmpty) return;

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Confirmar Exclusão',
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Excluir ${vm.selecionados.length} agendamento(s)?',
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
        actionsPadding: const EdgeInsets.only(bottom: 10, right: 10),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white70,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancelar',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Excluir',
              style: GoogleFonts.orbitron(fontSize: 14),
            ),
          ),
        ],
      ),
    );

    if (ok == true) {
      final success = await vm.excluirSelecionados();
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Agendamentos excluídos')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(vm.errorMessage ?? 'Erro ao excluir')),
        );
      }
    }
  }
}
