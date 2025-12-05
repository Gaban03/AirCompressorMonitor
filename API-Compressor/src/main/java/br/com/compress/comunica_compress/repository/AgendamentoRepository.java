package br.com.compress.comunica_compress.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.compress.comunica_compress.model.Agendamento;

public interface AgendamentoRepository extends JpaRepository<Agendamento, Integer> {

        List<Agendamento> findByCompressorId(Integer compressorId);

        List<Agendamento> findByAtivoTrue();
}
