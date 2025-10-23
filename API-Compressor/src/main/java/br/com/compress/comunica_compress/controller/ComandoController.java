package br.com.compress.comunica_compress.controller;

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
@RequestMapping("/compressor")
public class ComandoController {

    @Autowired
    private ComandoService comandoService;

    @Autowired
    private ComandoRepository comandoRepository;

    @Operation(description = "Enviar/inserir comando de liga/desliga do compressor no banco")
    @PostMapping("/comando")
    @Transactional
    public ResponseEntity<ComandoResponseDTO> enviarComando(@RequestBody ComandoRequestDTO comandoTO) {
        Comando comando = comandoService.toEntity(comandoTO);
        comandoRepository.save(comando);
        ComandoResponseDTO responseDTO = new ComandoResponseDTO(
                comando.getId(),
                comando.getCompressor().getId(),
                comando.getComando(),
                comando.getDataHora());

        return ResponseEntity.ok(responseDTO);
    }

    @Operation(description = "Pegar o comando de liga/desliga do compressor no banco")
    @GetMapping("/comando")
    public ResponseEntity<ComandoResponseDTO> receberComando(@RequestParam Integer compressorId) {
        return comandoRepository
                .findTopByCompressorIdOrderByDataHoraDesc(compressorId)
                .map(comando -> new ComandoResponseDTO(
                        comando.getId(),
                        comando.getCompressor().getId(),
                        comando.getComando(),
                        comando.getDataHora()))
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
