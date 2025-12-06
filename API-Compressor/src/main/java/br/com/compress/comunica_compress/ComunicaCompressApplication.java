package br.com.compress.comunica_compress;

import java.util.TimeZone;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

import jakarta.annotation.PostConstruct;

@EnableScheduling
@SpringBootApplication
public class ComunicaCompressApplication {

	@PostConstruct
	public void init() {
		TimeZone.setDefault(TimeZone.getTimeZone("America/Sao_Paulo"));
		System.out.println(">>> TIMEZONE DEFINIDO PARA America/Sao_Paulo <<<");
	}

	public static void main(String[] args) {
		SpringApplication.run(ComunicaCompressApplication.class, args);
	}

}
