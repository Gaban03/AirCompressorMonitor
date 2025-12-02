part of '_dto_lib.dart';

class CompressorFalhasDto {
  final String id;
  final String descricao;
  final String horario;

  CompressorFalhasDto(
      {required this.id, required this.descricao, required this.horario});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'horario': horario,
    };
  }

  factory CompressorFalhasDto.fromJson(Map<String, dynamic> json) {
    return CompressorFalhasDto(
      id: json['id'] as String,
      descricao: json['descricao'] as String,
      horario: json['horario'] as String,
    );
  }
  String get horaFormatada => DateFormat.Hms().format(horario as DateTime);

  String get dataFormatada =>
      DateFormat('dd/MM/yyyy').format(horario as DateTime);

  String get dataHoraFormatada =>
      DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.parse(horario));
}
