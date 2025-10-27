package br.com.compress.comunica_compress.controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.com.compress.comunica_compress.dto.ComandoRequestDTO;
import br.com.compress.comunica_compress.dto.ComandoResponseDTO;
import br.com.compress.comunica_compress.model.Comando;
import br.com.compress.comunica_compress.repository.ComandoRepository;
import br.com.compress.comunica_compress.service.ComandoService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.transaction.Transactional;

@RestController
@RequestMapping("/ordemRemota")
public class ComandoController {

    @Autowired
    private ComandoService comandoService;

    @Autowired
    private ComandoRepository comandoRepository;

    @Operation(description = "Enviar/inserir comando de liga/desliga do compressor no banco")
    @PostMapping("/comando")
    @Transactional
    public ResponseEntity<ComandoResponseDTO> enviarComando(@RequestBody ComandoRequestDTO comandoDTO) {
        Comando comando = comandoService.toEntity(comandoDTO);
        comandoRepository.save(comando);
        ComandoResponseDTO responseDTO = new ComandoResponseDTO(
                comando.getId(),
                comando.getCompressor().getId(),
                comando.getComando(),
                comando.getCompressor().getEstado(),
                comando.getDataHora());

        return ResponseEntity.ok(responseDTO);
    }

    @Operation(summary = "Busca o último comando recente de um compressor", description = "Retorna o último comando do compressor nas últimas 21 horas. "
            + "Se não houver comandos nesse período, retorna 204.")
    @GetMapping("/comando")
    public ResponseEntity<ComandoResponseDTO> receberComando(@RequestParam Integer compressorId) {
        LocalDateTime limite = LocalDateTime.now().minusHours(21);
        return comandoRepository
                .findTopByCompressorIdAndDataHoraAfterOrderByDataHoraDesc(compressorId, limite)
                .map(comando -> new ComandoResponseDTO(
                        comando.getId(),
                        comando.getCompressor().getId(),
                        comando.getComando(),
                        comando.getCompressor().getEstado(),
                        comando.getDataHora()))
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.noContent().build());
    }
}
