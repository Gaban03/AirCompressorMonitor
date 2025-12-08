part of '_models_lib.dart';

class Agendamento {
  final int? id;
  final int compressorId;
  final List<String> diasSemana; // MONDAY, TUESDAY, ...
  final String horaInicio; // ex: "08:30"
  final String horaFim; // ex: "17:00"
  final bool ativo;
  final String? descricao;

  Agendamento({
    this.id,
    required this.compressorId,
    required this.diasSemana,
    required this.horaInicio,
    required this.horaFim,
    required this.ativo,
    this.descricao,
  });

  /// ✅ copyWith correto baseado nos campos existentes
  Agendamento copyWith({
    int? id,
    int? compressorId,
    List<String>? diasSemana,
    String? horaInicio,
    String? horaFim,
    bool? ativo,
    String? descricao,
  }) {
    return Agendamento(
      id: id ?? this.id,
      compressorId: compressorId ?? this.compressorId,
      diasSemana: diasSemana ?? this.diasSemana,
      horaInicio: horaInicio ?? this.horaInicio,
      horaFim: horaFim ?? this.horaFim,
      ativo: ativo ?? this.ativo,
      descricao: descricao ?? this.descricao,
    );
  }

  factory Agendamento.fromJson(Map<String, dynamic> json) {
    return Agendamento(
      id: json['id'],
      compressorId: json['compressorId'],
      diasSemana: List<String>.from(json['diasSemana']),
      horaInicio: json['horaInicio'],
      horaFim: json['horaFim'],
      ativo: json['ativo'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "compressorId": compressorId,
      "diasSemana": diasSemana,
      "horaInicio": horaInicio,
      "horaFim": horaFim,
      "ativo": ativo,
      "descricao": descricao,
    };
  }
}
