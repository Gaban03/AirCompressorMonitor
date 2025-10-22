package br.com.compress.comunica_compress.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import br.com.compress.comunica_compress.dto.EnviarComandoDTO;
import br.com.compress.comunica_compress.dto.ReceberComandoDTO;

@Controller
public class ComandoCompressorController {
    
    @MessageMapping("/comando")
    @SendTo("/topic/estado")
    public ReceberComandoDTO enviarComando(EnviarComandoDTO comando){
        return new ReceberComandoDTO(comando.compressorId(), comando.comando(), comando.horario());
    }
}
