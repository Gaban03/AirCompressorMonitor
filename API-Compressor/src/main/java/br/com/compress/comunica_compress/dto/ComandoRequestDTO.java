package br.com.compress.comunica_compress.dto;

public record ComandoRequestDTO(Integer compressorId,
        Boolean comando,
        String estado) {
}
