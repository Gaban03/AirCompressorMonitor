package br.com.compress.comunica_compress.dto;

import java.time.LocalDateTime;

import br.com.compress.comunica_compress.model.Falha;

public record CompressorDadosResponseDTO(
        LocalDateTime dataHora,
        Boolean ligado,
        Float temperaturaArComprimido,
        Float temperaturaAmbiente,
        Float temperaturaOleo,
        Float temperaturaOrvalho,
        Float pressaoArComprimido,
        Float horaCarga,
        Float horaTotal,
        Float pressaoCarga,
        Float pressaoAlivio,
        Falha idFalha
) {}
