package br.com.compress.comunica_compress.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.compress.comunica_compress.dto.CompressorDadosRequestDTO;
import br.com.compress.comunica_compress.dto.CompressorDadosResponseDTO;
import br.com.compress.comunica_compress.model.Compressor;
import br.com.compress.comunica_compress.model.CompressorDados;
import br.com.compress.comunica_compress.repository.CompressorDadosRepository;
import br.com.compress.comunica_compress.repository.CompressorRepository;
import jakarta.transaction.Transactional;

@Service
public class CompressorDadosService {

    @Autowired
    CompressorRepository compressorRepository;

    @Autowired
    CompressorDadosRepository compressorDadosRepository;

    // DTO → Entity
    public CompressorDados toEntity(CompressorDadosRequestDTO dto, Compressor compressor) {
        CompressorDados entity = new CompressorDados();
        entity.setEstado(dto.estado());
        entity.setTemperaturaArComprimido(dto.temperaturaArComprimido());
        entity.setTemperaturaAmbiente(dto.temperaturaAmbiente());
        entity.setTemperaturaOleo(dto.temperaturaOleo());
        entity.setTemperaturaOrvalho(dto.temperaturaOrvalho());
        entity.setPressaoArComprimido(dto.pressaoArComprimido());
        entity.setHoraCarga(dto.horaCarga());
        entity.setHoraTotal(dto.horaTotal());
        entity.setPressaoCarga(dto.pressaoCarga());
        entity.setPressaoAlivio(dto.pressaoAlivio());
        entity.setCompressor(compressor);
        return entity;
    }

    // Entity → DTO
    public CompressorDadosResponseDTO toResponse(CompressorDados entity) {
        return new CompressorDadosResponseDTO(
                entity.getDataHora(),
                entity.getEstado(),
                entity.getTemperaturaArComprimido(),
                entity.getTemperaturaAmbiente(),
                entity.getTemperaturaOleo(),
                entity.getTemperaturaOrvalho(),
                entity.getPressaoArComprimido(),
                entity.getHoraCarga(),
                entity.getHoraTotal(),
                entity.getPressaoAlivio(),
                entity.getPressaoCarga());
    }

    @Transactional
    public CompressorDadosResponseDTO salvar(CompressorDadosRequestDTO dto) {
        Compressor compressor = compressorRepository.findById(dto.compressorId())
                .orElseThrow(() -> new IllegalArgumentException("Compressor não encontrado: " + dto.compressorId()));

        CompressorDados compressorDadosEntity = toEntity(dto, compressor);
        CompressorDados saved = compressorDadosRepository.save(compressorDadosEntity);

        return toResponse(saved);
    }

    @Transactional
    public Optional<CompressorDados> buscarUltimaLeitura(Integer idCompressor) {
        return compressorDadosRepository.findTopByCompressorIdOrderByDataHoraDesc(idCompressor);
    }
}
