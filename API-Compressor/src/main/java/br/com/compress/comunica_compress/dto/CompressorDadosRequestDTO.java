package br.com.compress.comunica_compress.dto;

import br.com.compress.comunica_compress.enums.Estado;

public record CompressorDadosRequestDTO(
        Estado estado,
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
        Integer compressorId) {
}
