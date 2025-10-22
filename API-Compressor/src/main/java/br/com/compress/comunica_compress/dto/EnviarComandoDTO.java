package br.com.compress.comunica_compress.dto;

import java.time.LocalDateTime;

public record EnviarComandoDTO(Integer compressorId, Boolean comando, LocalDateTime horario) {

}
