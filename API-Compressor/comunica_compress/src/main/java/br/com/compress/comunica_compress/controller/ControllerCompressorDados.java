package br.com.compress.comunica_compress.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.compress.comunica_compress.model.CompressorDados;
import br.com.compress.comunica_compress.service.ServiceCompressorDados;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

@RestController
@RequestMapping("/compressor")
public class ControllerCompressorDados {

    @Autowired
    ServiceCompressorDados serviceCompressor;

    @Operation(description = "Enviar/inserir dados dos sensores do compressor no banco")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Dados inseridos com sucesso!"),
            @ApiResponse(responseCode = "400", description = "Erro ao inserir dados!")
    })
    @PostMapping("/dados")
    public ResponseEntity<CompressorDados> enviarDadosSensores(@RequestBody CompressorDados compressor) {
        CompressorDados salvo = serviceCompressor.salvar(compressor);
        return ResponseEntity.ok(salvo);
    }

    @Operation(description = "GET/recebe os dados dos sensores do compressor no banco")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Dados recebidos com sucesso!"),
            @ApiResponse(responseCode = "400", description = "Erro ao receber dados!")
    })
    @GetMapping("/dados/{idCompressor}")
    public ResponseEntity<CompressorDados> lerDadosSensores(@PathVariable Integer idCompressor) {
        Optional<CompressorDados> dadosRecentes = serviceCompressor.buscarUltimaLeitura(idCompressor);
        return dadosRecentes.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }
}
