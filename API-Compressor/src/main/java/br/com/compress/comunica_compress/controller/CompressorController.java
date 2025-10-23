package br.com.compress.comunica_compress.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.com.compress.comunica_compress.dto.AtualizarLigadoDTO;
import br.com.compress.comunica_compress.model.Compressor;
import br.com.compress.comunica_compress.repository.CompressorRepository;
import jakarta.transaction.Transactional;

@RestController
@RequestMapping("/compressor")
public class CompressorController {

    @Autowired
    private CompressorRepository compressorRepository;

    @PostMapping("/estado")
    @Transactional
    public ResponseEntity<Compressor> atualizarEstado(@RequestBody AtualizarLigadoDTO dto) {
        return compressorRepository.findById(dto.compressorId())
                .map(compressor -> {
                    compressor.setLigado(dto.ligado());
                    compressorRepository.save(compressor);
                    return ResponseEntity.ok(compressor);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/estado")
    public ResponseEntity<Compressor> getEstado(@RequestParam Integer compressorId) {
        return compressorRepository.findById(compressorId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
