package br.com.compress.comunica_compress.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.compress.comunica_compress.dto.CompressorDadosRequestDTO;
import br.com.compress.comunica_compress.dto.CompressorDadosResponseDTO;
import br.com.compress.comunica_compress.model.Compressor;
import br.com.compress.comunica_compress.model.CompressorDados;
import br.com.compress.comunica_compress.model.Falha;
import br.com.compress.comunica_compress.repository.CompressorDadosRepository;
import br.com.compress.comunica_compress.repository.CompressorRepository;
import br.com.compress.comunica_compress.repository.FalhaRepository;
import jakarta.transaction.Transactional;

@Service
public class CompressorDadosService {

    @Autowired
    CompressorRepository compressorRepository;

    @Autowired
    CompressorDadosRepository compressorDadosRepository;

    @Autowired
    FalhaRepository falhaRepository;

    // DTO → Entity
    public CompressorDados toEntity(CompressorDadosRequestDTO dto, Compressor compressor, Falha falha) {
        CompressorDados entity = new CompressorDados();
        entity.setLigado(dto.ligado());
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
        entity.setFalha(falha);
        return entity;
    }

    // Entity → DTO
    public CompressorDadosResponseDTO toResponse(CompressorDados entity) {
        return new CompressorDadosResponseDTO(
                entity.getDataHora(),
                entity.getLigado(),
                entity.getTemperaturaArComprimido(),
                entity.getTemperaturaAmbiente(),
                entity.getTemperaturaOleo(),
                entity.getTemperaturaOrvalho(),
                entity.getPressaoArComprimido(),
                entity.getHoraCarga(),
                entity.getHoraTotal(),
                entity.getPressaoCarga(),
                entity.getPressaoAlivio(),
                entity.getFalha());
    }

    @Transactional
    public CompressorDadosResponseDTO salvar(CompressorDadosRequestDTO dto) {
        Compressor compressor = compressorRepository.findById(dto.compressorId())
                .orElseThrow(
                        () -> new IllegalArgumentException("Compressor de id: " + dto.compressorId() + "não existe!"));

        Falha falha = falhaRepository.findById(dto.falhaId())
                .orElseThrow(() -> new IllegalArgumentException("Falha " + dto.falhaId() + "não existe!"));

        CompressorDados compressorDadosEntity = toEntity(dto, compressor, falha);
        CompressorDados saved = compressorDadosRepository.save(compressorDadosEntity);

        return toResponse(saved);
    }

    @Transactional
    public Optional<CompressorDados> buscarUltimaLeitura(Integer idCompressor) {
        return compressorDadosRepository.findTopByCompressorIdOrderByDataHoraDesc(idCompressor);
    }
}
