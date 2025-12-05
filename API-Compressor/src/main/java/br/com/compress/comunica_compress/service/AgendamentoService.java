package br.com.compress.comunica_compress.service;

import java.time.LocalTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.compress.comunica_compress.dto.AgendamentoRequestDTO;
import br.com.compress.comunica_compress.dto.AgendamentoResponseDTO;
import br.com.compress.comunica_compress.model.Agendamento;
import br.com.compress.comunica_compress.model.Compressor;
import br.com.compress.comunica_compress.repository.AgendamentoRepository;
import br.com.compress.comunica_compress.repository.CompressorRepository;

@Service
public class AgendamentoService {

    private final AgendamentoRepository agendamentoRepository;
    private final CompressorRepository compressorRepository;

    public AgendamentoService(AgendamentoRepository agendamentoRepository,
            CompressorRepository compressorRepository) {
        this.agendamentoRepository = agendamentoRepository;
        this.compressorRepository = compressorRepository;
    }

    // ---------- CRUD PRINCIPAL (formato do MOBILE) ----------

    @Transactional
    public AgendamentoResponseDTO criar(AgendamentoRequestDTO dto) {
        Compressor compressor = compressorRepository.findById(dto.compressorId())
                .orElseThrow(() -> new IllegalArgumentException("Compressor não encontrado"));

        validarDto(dto);

        Agendamento ag = new Agendamento();
        ag.setCompressor(compressor);
        ag.setDiasSemana(dto.diasSemana());
        ag.setHoraInicio(dto.horaInicio());
        ag.setHoraFim(dto.horaFim());
        ag.setAtivo(Boolean.TRUE.equals(dto.ativo()));
        ag.setDescricao(dto.descricao());

        agendamentoRepository.save(ag);
        return toResponse(ag);
    }

    public AgendamentoResponseDTO buscarPorId(Integer id) {
        Agendamento ag = agendamentoRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Agendamento não encontrado"));
        return toResponse(ag);
    }

    public List<AgendamentoResponseDTO> listar(Integer compressorId) {
        List<Agendamento> lista;

        if (compressorId != null) {
            lista = agendamentoRepository.findByCompressorId(compressorId);
        } else {
            lista = agendamentoRepository.findAll();
        }

        return lista.stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional
    public void excluir(Integer id) {
        if (!agendamentoRepository.existsById(id)) {
            throw new IllegalArgumentException("Agendamento não encontrado");
        }
        agendamentoRepository.deleteById(id);
    }

    @Transactional
    public void excluirEmLote(List<Integer> ids) {
        agendamentoRepository.deleteAllById(ids);
    }

    @Transactional
    public AgendamentoResponseDTO alterarAtivo(Integer id, boolean ativo) {
        Agendamento ag = agendamentoRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Agendamento não encontrado"));
        ag.setAtivo(ativo);
        agendamentoRepository.save(ag);
        return toResponse(ag);
    }

    @Transactional
    public AgendamentoResponseDTO atualizar(Integer id, AgendamentoRequestDTO dto) {
        Agendamento ag = agendamentoRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Agendamento não encontrado"));

        Compressor compressor = compressorRepository.findById(dto.compressorId())
                .orElseThrow(() -> new IllegalArgumentException("Compressor não encontrado"));

        validarDto(dto);

        ag.setCompressor(compressor);
        ag.setDiasSemana(dto.diasSemana());
        ag.setHoraInicio(dto.horaInicio());
        ag.setHoraFim(dto.horaFim());
        ag.setAtivo(Boolean.TRUE.equals(dto.ativo()));
        ag.setDescricao(dto.descricao());

        // resetar controle do executor caso atualizado
        ag.setUltimoDisparoInicio(null);
        ag.setUltimoDisparoFim(null);

        agendamentoRepository.save(ag);
        return toResponse(ag);
    }

    // ---------- VALIDAÇÃO ----------

    private void validarDto(AgendamentoRequestDTO dto) {
        if (dto.diasSemana() == null || dto.diasSemana().isEmpty()) {
            throw new IllegalArgumentException("Ao menos um dia da semana deve ser informado.");
        }

        LocalTime inicio = dto.horaInicio();
        LocalTime fim = dto.horaFim();

        if (inicio == null || fim == null) {
            throw new IllegalArgumentException("horaInicio e horaFim são obrigatórios.");
        }

        if (!inicio.isBefore(fim)) {
            throw new IllegalArgumentException("horaInicio deve ser antes de horaFim.");
        }
    }

    // ---------- MAPEAMENTO ENTITY -> DTO ----------

    private AgendamentoResponseDTO toResponse(Agendamento ag) {
        return new AgendamentoResponseDTO(
                ag.getId(),
                ag.getCompressor().getId(),
                ag.getDiasSemana(),
                ag.getHoraInicio(),
                ag.getHoraFim(),
                ag.getAtivo(),
                ag.getDescricao());
    }
}
