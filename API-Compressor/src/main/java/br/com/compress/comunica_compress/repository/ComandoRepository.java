package br.com.compress.comunica_compress.repository;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.compress.comunica_compress.model.Comando;

public interface ComandoRepository extends JpaRepository<Comando, Integer> {
    Optional<Comando> findTopByCompressorIdAndDataHoraAfterOrderByDataHoraDesc(
            Integer idCompressor,
            LocalDateTime dataLimite);

}
