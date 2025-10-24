package br.com.compress.comunica_compress.dto;

import java.time.LocalDateTime;

public record ComandoResponseDTO(Integer id,
        Integer compressorId,
        Boolean comando,
        String estado,
        LocalDateTime dataHora) {
}
