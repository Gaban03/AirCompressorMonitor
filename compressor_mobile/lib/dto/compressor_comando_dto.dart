part of '_dto_lib.dart';

class CompressorComandoDto {
  final int compressorId;
  final bool comando;

  CompressorComandoDto({
    required this.compressorId,
    required this.comando,
  });

  Map<String, dynamic> toJson() {
    return {
      'compressorId': compressorId,
      'comando': comando,
    };
  }

  factory CompressorComandoDto.fromJson(Map<String, dynamic> json) {
    return CompressorComandoDto(
      compressorId: json['compressorId'] as int,
      comando: json['comando'] as bool,
    );
  }
}
