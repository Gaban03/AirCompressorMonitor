package br.com.compress.comunica_compress.dto;

import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.List;

public record AgendamentoRequestDTO(
        Integer compressorId,
        List<DayOfWeek> diasSemana,
        LocalTime horaInicio,
        LocalTime horaFim,
        Boolean ativo,
        String descricao) {
}
