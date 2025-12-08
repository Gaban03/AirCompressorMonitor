part of "_view_model_lib.dart";

class AgendamentoViewModel extends BaseViewModel {
  final AgendamentoService _service = getIt<AgendamentoService>();

  List<Agendamento> agendamentos = [];

  Agendamento? agendamentoSelecionado;

  final List<int> selecionados = [];

  Future<void> carregarAgendamentos() async {
    try {
      setLoading(true);
      clearError();

      final lista = await _service.listarAgendamentos();
      agendamentos = lista;

      notifyListeners();
    } catch (e) {
      setError("Erro ao carregar agendamentos!");
    } finally {
      setLoading(false);
    }
  }

  Future<void> buscarAgendamento(int id) async {
    try {
      setLoading(true);
      clearError();

      agendamentoSelecionado = await _service.buscarPorId(id);

      notifyListeners();
    } catch (e) {
      setError("Erro ao buscar agendamento!");
    } finally {
      setLoading(false);
    }
  }

  Future<bool> criarAgendamento(Agendamento novo) async {
    try {
      setLoading(true);
      clearError();

      final criado = await _service.criarAgendamento(novo);

      agendamentos.add(criado);
      notifyListeners();

      return true;
    } catch (e) {
      setError("Erro ao criar agendamento!");
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> atualizarAgendamento(int id, Agendamento atualizado) async {
    try {
      setLoading(true);
      clearError();

      final alterado = await _service.atualizarAgendamento(id, atualizado);

      final index = agendamentos.indexWhere((e) => e.id == id);
      if (index != -1) {
        agendamentos[index] = alterado;
      }

      notifyListeners();
      return true;
    } catch (e) {
      setError("Erro ao atualizar agendamento!");
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> excluirAgendamento(int id) async {
    try {
      setLoading(true);
      clearError();

      await _service.excluirAgendamento(id);

      agendamentos.removeWhere((e) => e.id == id);
      selecionados.remove(id);

      notifyListeners();
      return true;
    } catch (e) {
      setError("Erro ao excluir agendamento!");
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> excluirSelecionados() async {
    if (selecionados.isEmpty) return false;

    try {
      setLoading(true);
      clearError();

      await _service.excluirEmLote(selecionados);

      agendamentos.removeWhere((e) => selecionados.contains(e.id));
      selecionados.clear();

      notifyListeners();
      return true;
    } catch (e) {
      setError("Erro ao excluir agendamentos!");
      return false;
    } finally {
      setLoading(false);
    }
  }

  void alternarSelecao(int id) {
    if (selecionados.contains(id)) {
      selecionados.remove(id);
    } else {
      selecionados.add(id);
    }

    notifyListeners();
  }

  Future<void> alterarStatus(int id, bool ativo) async {
    try {
      clearError();
      setLoading(true);

      await _service.ativarAgendamento(id, ativo);

      final index = agendamentos.indexWhere((x) => x.id == id);
      if (index != -1) {
        agendamentos[index] = agendamentos[index].copyWith(ativo: ativo);
      }

      notifyListeners();
    } catch (e) {
      setError("Erro ao alterar status!");
    } finally {
      setLoading(false);
    }
  }

  void limparSelecao() {
    selecionados.clear();
    agendamentoSelecionado = null;
    notifyListeners();
  }
}
