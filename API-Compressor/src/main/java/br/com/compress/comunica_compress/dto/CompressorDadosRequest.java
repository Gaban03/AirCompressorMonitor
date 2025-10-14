package br.com.compress.comunica_compress.dto;

public record CompressorDadosRequest(
        Boolean estado,
        Float temperaturaArComprimido,
        Float temperaturaAmbiente,
        Float temperaturaOleo,
        Float pressaoArComprimido,
        Float pressaoCarga,
        Float horaCarga,
        Float horaTotal,
        Integer compressorId) {
}
