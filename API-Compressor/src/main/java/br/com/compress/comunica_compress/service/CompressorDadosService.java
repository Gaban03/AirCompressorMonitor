package br.com.compress.comunica_compress.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.compress.comunica_compress.dto.CompressorDadosRequest;
import br.com.compress.comunica_compress.dto.CompressorDadosResponse;
import br.com.compress.comunica_compress.model.Compressor;
import br.com.compress.comunica_compress.model.CompressorDados;
import br.com.compress.comunica_compress.repository.CompressorDadosRepository;
import br.com.compress.comunica_compress.repository.CompressorRepository;
import jakarta.transaction.Transactional;

@Service
public class CompressorDadosService {

    @Autowired
    CompressorRepository compressorRepository;

    // DTO → Entity
    public CompressorDados toEntity(CompressorDadosRequest dto, Compressor compressor) {
        CompressorDados entity = new CompressorDados();
        entity.setEstado(dto.estado());
        entity.setTemperaturaArComprimido(dto.temperaturaArComprimido());
        entity.setTemperaturaAmbiente(dto.temperaturaAmbiente());
        entity.setTemperaturaOleo(dto.temperaturaOleo());
        entity.setPressaoArComprimido(dto.pressaoArComprimido());
        entity.setPressaoCarga(dto.pressaoCarga());
        entity.setHoraCarga(dto.horaCarga());
        entity.setHoraTotal(dto.horaTotal());
        entity.setCompressor(compressor);
        return entity;
    }

    // Entity → DTO
    public CompressorDadosResponse toResponse(CompressorDados entity) {
        return new CompressorDadosResponse(
                entity.getId(),
                entity.getDataHora(),
                entity.getEstado(),
                entity.getTemperaturaArComprimido(),
                entity.getTemperaturaAmbiente(),
                entity.getTemperaturaOleo(),
                entity.getPressaoArComprimido(),
                entity.getPressaoCarga(),
                entity.getHoraCarga(),
                entity.getHoraTotal(),
                entity.getCompressor().getId());
    }

    @Autowired
    CompressorDadosRepository compressorDadosRepository;

    @Transactional
    public CompressorDadosResponse salvar(CompressorDadosRequest dto) {
         // valida se o compressor existe
        Compressor compressor = compressorRepository.findById(dto.compressorId())
                .orElseThrow(() -> new IllegalArgumentException("Compressor não encontrado: " + dto.compressorId()));

        // converte DTO -> Entity
        CompressorDados entity = toEntity(dto, compressor);

        // salva
        CompressorDados saved = compressorDadosRepository.save(entity);

        // converte Entity -> Response
        return toResponse(saved);
    }

    @Transactional
    public Optional<CompressorDados> buscarUltimaLeitura(Integer idCompressor) {
        return compressorDadosRepository.findTopByCompressorIdOrderByDataHoraDesc(idCompressor);
    }
}
