package br.com.compress.comunica_compress.dto;

import java.time.LocalDateTime;

public record CompressorDadosResponse(
        Integer id,
        LocalDateTime dataHora,
        Boolean estado,
        Float temperaturaArComprimido,
        Float temperaturaAmbiente,
        Float temperaturaOleo,
        Float pressaoArComprimido,
        Float pressaoCarga,
        Float horaCarga,
        Float horaTotal,
        Integer compressorId
) {}
