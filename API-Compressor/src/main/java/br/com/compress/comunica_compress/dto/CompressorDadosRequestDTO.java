package br.com.compress.comunica_compress.dto;

public record CompressorDadosRequestDTO(
                Boolean ligado,
                Float temperaturaArComprimido,
                Float temperaturaAmbiente,
                Float temperaturaOleo,
                Float temperaturaOrvalho,
                Float pressaoArComprimido,
                Float horaCarga,
                Float horaTotal,
                Float pressaoAlivio,
                Float pressaoCarga,
                Integer compressorId,
                String falhaId) {
}
