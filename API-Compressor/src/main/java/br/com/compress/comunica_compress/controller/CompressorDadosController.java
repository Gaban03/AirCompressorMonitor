package br.com.compress.comunica_compress.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.com.compress.comunica_compress.dto.CompressorDadosRequestDTO;
import br.com.compress.comunica_compress.dto.CompressorDadosResponseDTO;
import br.com.compress.comunica_compress.dto.CompressorEstadoDTO;
import br.com.compress.comunica_compress.model.CompressorDados;
import br.com.compress.comunica_compress.service.CompressorDadosService;
import io.swagger.v3.oas.annotations.Operation;

@RestController
@RequestMapping("/compressor")
public class CompressorDadosController {

        @Autowired
        private CompressorDadosService compressorDadosService;

        @Operation(description = "Enviar/inserir dados dos sensores do compressor no banco")
        @PostMapping("/dados")
        public ResponseEntity<CompressorDadosResponseDTO> enviarDadosSensores(
                        @RequestBody CompressorDadosRequestDTO request) {
                return ResponseEntity.ok(compressorDadosService.salvar(request));
        }

        @Operation(description = "GET/recebe os dados dos sensores do compressor no banco")
        @GetMapping("/dados")
        public ResponseEntity<CompressorDadosResponseDTO> ultimosDadosSensores(@RequestParam Integer idCompressor) {

                Optional<CompressorDados> dadosRecentes = compressorDadosService.buscarUltimaLeitura(idCompressor);

                return dadosRecentes
                                .map(dado -> ResponseEntity.ok(compressorDadosService.toResponse(dado)))
                                .orElse(ResponseEntity.notFound().build());
        }

        @GetMapping("/dados-dashboard")
        public ResponseEntity<List<CompressorDadosResponseDTO>> cincoUltimosDadosSensores(
                        @RequestParam Integer idCompressor) {

                List<CompressorDados> dadosDashboard = compressorDadosService.buscarDadosDashboard(idCompressor);

                if (dadosDashboard.isEmpty()) {
                        return ResponseEntity.notFound().build();
                }

                List<CompressorDadosResponseDTO> resposta = dadosDashboard.stream()
                                .map(compressorDadosService::toResponse)
                                .toList();

                return ResponseEntity.ok(resposta);
        }

        @GetMapping("/estado")
        public ResponseEntity<CompressorEstadoDTO> getEstado(@RequestParam Integer idCompressor) {
                var ultimosDados = compressorDadosService.buscarUltimaLeitura(idCompressor);
                return ResponseEntity.ok(new CompressorEstadoDTO(ultimosDados.get().getEstado()));
        }

}
