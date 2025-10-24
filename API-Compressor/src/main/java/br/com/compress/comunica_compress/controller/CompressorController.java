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
import br.com.compress.comunica_compress.model.Compressor;
import br.com.compress.comunica_compress.repository.CompressorRepository;
import jakarta.transaction.Transactional;

@RestController
@RequestMapping("/confirmacao")
public class CompressorController {

    @Autowired
    private CompressorRepository compressorRepository;

    @PostMapping("/ligado")
    @Transactional
    public ResponseEntity<Compressor> atualizarEstado(@RequestBody ComandoRequestDTO dto) {
        return compressorRepository.findById(dto.compressorId())
                .map(compressor -> {
                    compressor.setLigado(dto.comando());
                    compressorRepository.save(compressor);
                    return ResponseEntity.ok(compressor);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/ligado")
    public ResponseEntity<Compressor> getEstado(@RequestParam Integer compressorId) {
        return compressorRepository.findById(compressorId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
