package br.com.compress.comunica_compress.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.compress.comunica_compress.dto.ComandoRequestDTO;
import br.com.compress.comunica_compress.model.Agendamento;
import br.com.compress.comunica_compress.repository.AgendamentoRepository;

@Service
public class AgendamentoExecutor {

    private final AgendamentoRepository repo;
    private final ComandoService comandoService;

    public AgendamentoExecutor(AgendamentoRepository repo, ComandoService comandoService) {
        this.repo = repo;
        this.comandoService = comandoService;
    }

    @Scheduled(cron = "0 * * * * *", zone = "America/Sao_Paulo") // a cada 1 minuto no segundo 0
    @Transactional
    public void executar() {
        LocalDateTime agoraDateTime = LocalDateTime.now().withSecond(0).withNano(0);
        LocalTime agora = agoraDateTime.toLocalTime();
        DayOfWeek hoje = LocalDate.now().getDayOfWeek();

        List<Agendamento> ativos = repo.findByAtivoTrue();

        for (Agendamento ag : ativos) {

            // se não está configurado para hoje, pula
            if (ag.getDiasSemana() == null || !ag.getDiasSemana().contains(hoje)) {
                continue;
            }

            // LIGAR
            if (ag.getHoraInicio().equals(agora)) {
                if (deveDispararInicio(ag, agoraDateTime.toLocalDate())) {
                    disparar(ag, true);
                    ag.setUltimoDisparoInicio(agoraDateTime);
                }
            }

            // DESLIGAR
            if (ag.getHoraFim().equals(agora)) {
                if (deveDispararFim(ag, agoraDateTime.toLocalDate())) {
                    disparar(ag, false);
                    ag.setUltimoDisparoFim(agoraDateTime);
                }
            }

            repo.save(ag);
        }
    }

    private boolean deveDispararInicio(Agendamento ag, LocalDate hoje) {
        if (ag.getUltimoDisparoInicio() == null)
            return true;
        return !ag.getUltimoDisparoInicio().toLocalDate().equals(hoje);
    }

    private boolean deveDispararFim(Agendamento ag, LocalDate hoje) {
        if (ag.getUltimoDisparoFim() == null)
            return true;
        return !ag.getUltimoDisparoFim().toLocalDate().equals(hoje);
    }

    private void disparar(Agendamento ag, boolean comando) {
        comandoService.salvar(new ComandoRequestDTO(
                ag.getCompressor().getId(),
                comando));
    }
}
