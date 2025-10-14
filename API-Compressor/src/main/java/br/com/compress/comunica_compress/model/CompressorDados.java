package br.com.compress.comunica_compress.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Getter
@Setter
@EqualsAndHashCode
@Table(name = "registro_compressor")
public class CompressorDados {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @DateTimeFormat
    private LocalDateTime dataHora = LocalDateTime.now();

    @NotNull
    private Boolean estado;

    @NotNull
    private Float temperaturaArComprimido;

    @NotNull
    private Float temperaturaAmbiente;

    @NotNull
    private Float temperaturaOleo;

    @NotNull
    private Float pressaoArComprimido;

    @NotNull
    private Float pressaoCarga;

    @NotNull
    private Float horaCarga;

    @NotNull
    private Float horaTotal;

    @ManyToOne
    @JoinColumn(name = "compressor_id", nullable = false)
    private Compressor compressor;
}
