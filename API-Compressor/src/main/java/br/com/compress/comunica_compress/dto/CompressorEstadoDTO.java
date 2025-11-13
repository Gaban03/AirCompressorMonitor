package br.com.compress.comunica_compress.dto;

import br.com.compress.comunica_compress.model.CompressorDados;

public record CompressorEstadoDTO(
        String estado) {
    public CompressorEstadoDTO(CompressorDados compressor) {
        this(compressor.getEstado());
    }
}
