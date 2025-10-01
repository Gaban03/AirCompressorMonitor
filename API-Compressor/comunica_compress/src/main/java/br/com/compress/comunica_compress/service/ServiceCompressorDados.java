package br.com.compress.comunica_compress.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.compress.comunica_compress.model.CompressorDados;
import br.com.compress.comunica_compress.repository.RepositoryCompressorDados;
import jakarta.transaction.Transactional;

@Service
public class ServiceCompressorDados {

    @Autowired
    RepositoryCompressorDados repositoryCompressorDados;

    @Transactional
    public CompressorDados salvar(CompressorDados compressorDados) {
        return repositoryCompressorDados.save(compressorDados);
    }

    public Optional<CompressorDados> buscarPorId(Integer id) {
        return repositoryCompressorDados.findById(id);
    }

    @Transactional
    public Optional<CompressorDados> buscarUltimaLeitura(Integer idCompressor){
        return repositoryCompressorDados.findTopByCompressorIdOrderByDataHoraDesc(idCompressor);
    }
}
