part of '_models_lib.dart';

class CompressorDados {
  final DateTime dataHora;
  final String estado;
  final bool ligado;
  final double temperaturaArComprimido;
  final double temperaturaAmbiente;
  final double temperaturaOleo;
  final double temperaturaOrvalho;
  final double pressaoArComprimido;
  final double horaCarga;
  final double horaTotal;
  final double pressaoCarga;
  final double pressaoAlivio;

  const CompressorDados({
    required this.dataHora,
    required this.estado,
    required this.ligado,
    required this.temperaturaArComprimido,
    required this.temperaturaAmbiente,
    required this.temperaturaOleo,
    required this.temperaturaOrvalho,
    required this.pressaoArComprimido,
    required this.horaCarga,
    required this.horaTotal,
    required this.pressaoCarga,
    required this.pressaoAlivio,
  });

  factory CompressorDados.fromJson(Map<String, dynamic> json) {
    return CompressorDados(
      dataHora: DateTime.parse(json['dataHora']),
      estado: json['estado'] as String,
      ligado: json['ligado'] as bool,
      temperaturaArComprimido: (json['temperaturaArComprimido'] as num).toDouble(),
      temperaturaAmbiente: (json['temperaturaAmbiente'] as num).toDouble(),
      temperaturaOleo: (json['temperaturaOleo'] as num).toDouble(),
      temperaturaOrvalho: (json['temperaturaOrvalho'] as num).toDouble(),
      pressaoArComprimido: (json['pressaoArComprimido'] as num).toDouble(),
      horaCarga: (json['horaCarga'] as num).toDouble(),
      horaTotal: (json['horaTotal'] as num).toDouble(),
      pressaoCarga: (json['pressaoCarga'] as num).toDouble(),
      pressaoAlivio: (json['pressaoAlivio'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'dataHora': dataHora.toIso8601String(),
        'estado': estado,
        'ligado': ligado,
        'temperaturaArComprimido': temperaturaArComprimido,
        'temperaturaAmbiente': temperaturaAmbiente,
        'temperaturaOleo': temperaturaOleo,
        'temperaturaOrvalho': temperaturaOrvalho,
        'pressaoArComprimido': pressaoArComprimido,
        'horaCarga': horaCarga,
        'horaTotal': horaTotal,
        'pressaoCarga': pressaoCarga,
        'pressaoAlivio': pressaoAlivio,
      };
}
