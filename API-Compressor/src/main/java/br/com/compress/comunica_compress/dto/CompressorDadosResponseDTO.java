package br.com.compress.comunica_compress.dto;

import java.time.LocalDateTime;

public record CompressorDadosResponseDTO(
        LocalDateTime dataHora,
        Boolean estado,
        Float temperaturaArComprimido,
        Float temperaturaAmbiente,
        Float temperaturaOleo,
        Float temperaturaOrvalho,
        Float pressaoArComprimido,
        Float horaCarga,
        Float horaTotal,
        Float pressaoCarga,
        Float pressaoAlivio
) {}
