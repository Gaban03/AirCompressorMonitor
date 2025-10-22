package br.com.compress.comunica_compress.dto;

import java.time.LocalDateTime;

public record ReceberComandoDTO(Integer compressorId, Boolean comando, LocalDateTime horario) {
    
}
