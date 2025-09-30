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
    RepositoryCompressorDados repositoryCompressor;

    @Transactional
    public CompressorDados salvar(CompressorDados compressor) {
        return repositoryCompressor.save(compressor);
    }

    public Optional<CompressorDados> buscarPorId(Integer id) {
        return repositoryCompressor.findById(id);

    }

    public CompressorDados atualizaDados(Integer id, CompressorDados compressorAtualizado) {

        var optionalCompreess = buscarPorId(id);
        if (!optionalCompreess.isPresent())
            throw new IllegalArgumentException("O compressor não foi encontrado.");
        var compressExiste = optionalCompreess.get();

        
        compressExiste.setTemperaturaArComprimido(compressorAtualizado.getTemperaturaArComprimido());
        compressExiste.setTemperaturaOleo(compressorAtualizado.getTemperaturaOleo());
        compressExiste.setDataHora(compressorAtualizado.getDataHora());
        compressExiste.setEstado(compressorAtualizado.getEstado());
        compressExiste.setHoraCarga(compressorAtualizado.getHoraCarga());
        compressExiste.setHoraTotal(compressorAtualizado.getHoraTotal());
        compressExiste.setPressaoCarga(compressorAtualizado.getPressaoCarga());
        compressExiste.setPressaoArComprimido(compressorAtualizado.getPressaoArComprimido()); 
        compressExiste.setTemperaturaAmbiente(compressorAtualizado.getTemperaturaAmbiente());
        
        var compressorSalvo = repositoryCompressor.save(compressExiste);
       
        return compressorSalvo;
    }


    public Optional<CompressorDados> buscarUltimaLeitura(Integer idCompressor){
        return repositoryCompressor.findTopByCompressorIdOrderByDataHoraDesc(idCompressor);
    }
}
