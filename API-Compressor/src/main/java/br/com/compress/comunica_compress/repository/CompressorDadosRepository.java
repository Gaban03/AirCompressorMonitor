package br.com.compress.comunica_compress.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.compress.comunica_compress.model.CompressorDados;

import java.util.Optional;

public interface CompressorDadosRepository extends JpaRepository<CompressorDados,Integer> {

Optional<CompressorDados> findTopByCompressorIdOrderByDataHoraDesc(Integer idCompressor);
    
}