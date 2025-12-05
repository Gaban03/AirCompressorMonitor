package br.com.compress.comunica_compress.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.com.compress.comunica_compress.dto.AgendamentoRequestDTO;
import br.com.compress.comunica_compress.dto.AgendamentoResponseDTO;
import br.com.compress.comunica_compress.service.AgendamentoService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/ordemRemota/agendamentos")
public class AgendamentoController {

    private final AgendamentoService agendamentoService;

    public AgendamentoController(AgendamentoService agendamentoService) {
        this.agendamentoService = agendamentoService;
    }

    @GetMapping
    @Operation(summary = "Listar agendamentos")
    public ResponseEntity<List<AgendamentoResponseDTO>> listar(
            @RequestParam(required = false) Integer compressorId) {

        var lista = agendamentoService.listar(compressorId);
        return ResponseEntity.ok(lista);
    }

    @PostMapping
    @Transactional
    @Operation(summary = "Criar agendamento de comando")
    public ResponseEntity<AgendamentoResponseDTO> criar(@RequestBody @Valid AgendamentoRequestDTO dto) {
        AgendamentoResponseDTO response = agendamentoService.criar(dto);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    @Operation(summary = "Buscar agendamento por ID")
    public ResponseEntity<AgendamentoResponseDTO> buscarPorId(@PathVariable Integer id) {
        AgendamentoResponseDTO response = agendamentoService.buscarPorId(id);
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}")
    @Transactional
    @Operation(summary = "Atualizar agendamento")
    public ResponseEntity<AgendamentoResponseDTO> atualizar(
            @PathVariable Integer id,
            @RequestBody @Valid AgendamentoRequestDTO dto) {

        AgendamentoResponseDTO response = agendamentoService.atualizar(id, dto);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    @Transactional
    @Operation(summary = "Excluir agendamento")
    public ResponseEntity<Void> excluir(@PathVariable Integer id) {
        agendamentoService.excluir(id);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping
    @Transactional
    @Operation(summary = "Excluir agendamentos em lote")
    public ResponseEntity<Void> excluirEmLote(@RequestBody List<Integer> ids) {
        agendamentoService.excluirEmLote(ids);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}/ativo")
    @Transactional
    @Operation(summary = "Alterar status ativo do agendamento")
    public ResponseEntity<AgendamentoResponseDTO> alterarAtivo(
            @PathVariable Integer id,
            @RequestParam boolean ativo) {

        AgendamentoResponseDTO response = agendamentoService.alterarAtivo(id, ativo);
        return ResponseEntity.ok(response);
    }
}
