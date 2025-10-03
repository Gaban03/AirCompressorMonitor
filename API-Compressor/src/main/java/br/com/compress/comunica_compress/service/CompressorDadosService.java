package br.com.compress.comunica_compress.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.compress.comunica_compress.model.CompressorDados;
import br.com.compress.comunica_compress.repository.CompressorDadosRepository;
import jakarta.transaction.Transactional;

@Service
public class CompressorDadosService {

    @Autowired
    CompressorDadosRepository compressorDadosRepository;

    @Transactional
    public CompressorDados salvar(CompressorDados compressorDados) {
        return compressorDadosRepository.save(compressorDados);
    }

    public Optional<CompressorDados> buscarPorId(Integer id) {
        return compressorDadosRepository.findById(id);
    }

    @Transactional
    public Optional<CompressorDados> buscarUltimaLeitura(Integer idCompressor){
        return compressorDadosRepository.findTopByCompressorIdOrderByDataHoraDesc(idCompressor);
    }
}
