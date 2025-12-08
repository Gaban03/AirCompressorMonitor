part of '_services_lib.dart';

class AgendamentoService extends BaseService {
  AgendamentoService({required super.baseUrl});

  Future<List<Agendamento>> listarAgendamentos() async {
    final jsonData = await get('ordemRemota/agendamentos?compressorId=1');

    if (jsonData == null) return [];

    return (jsonData as List)
        .map((item) => Agendamento.fromJson(item))
        .toList();
  }

  Future<Agendamento?> buscarPorId(int id) async {
    final jsonData = await get('ordemRemota/agendamentos/$id');
    if (jsonData == null) return null;
    return Agendamento.fromJson(jsonData);
  }

  Future<Agendamento> criarAgendamento(Agendamento agendamento) async {
    final jsonData =
        await post('ordemRemota/agendamentos', agendamento.toJson());
    return Agendamento.fromJson(jsonData);
  }

  Future<Agendamento> atualizarAgendamento(
      int id, Agendamento agendamento) async {
    final jsonData = await put(
      'ordemRemota/agendamentos/$id',
      agendamento.toJson(),
    );
    return Agendamento.fromJson(jsonData);
  }

  Future<void> excluirAgendamento(int id) async {
    await delete('ordemRemota/agendamentos/$id');
  }

  Future<void> excluirEmLote(List<int> ids) async {
    await delete(
      'ordemRemota/agendamentos',
      body: ids,
    );
  }

  Future<void> ativarAgendamento(int id, bool ativo) async {
    await patch(
      'ordemRemota/agendamentos/$id/ativo?ativo=$ativo',
    );
  }
}
