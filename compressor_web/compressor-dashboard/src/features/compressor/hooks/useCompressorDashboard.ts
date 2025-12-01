import { useEffect, useState } from "react";
import {
  getCompressorLigado,
  getUltimoComando,
  getUltimosDadosSensores,
  getDadosDashboard,
  getFalhas,
} from "../api/compressorApi";
import type {
  ComandoResponseDTO,
  Compressor,
  CompressorDadosResponseDTO,
  PageFalhasDTO,
} from "../types";

export function useCompressorDashboard() {
  const [compressor, setCompressor] = useState<Compressor | null>(null);
  const [ultimoComando, setUltimoComando] = useState<ComandoResponseDTO | null>(null);
  const [dadosAtuais, setDadosAtuais] = useState<CompressorDadosResponseDTO | null>(
    null
  );
  const [dadosHistorico, setDadosHistorico] = useState<CompressorDadosResponseDTO[]>(
    []
  );
  const [falhasPage, setFalhasPage] = useState<PageFalhasDTO | null>(null);
  const [falhasPageNumber, setFalhasPageNumber] = useState(0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadAll() {
      try {
        setLoading(true);

        const [comp, comando, dados, historico, falhas] = await Promise.all([
          getCompressorLigado(),
          getUltimoComando(),
          getUltimosDadosSensores(),
          getDadosDashboard(),
          getFalhas(undefined, 0, 10),
        ]);

        setCompressor(comp);
        setUltimoComando(comando);
        setDadosAtuais(dados);
        setDadosHistorico(historico);
        setFalhasPage(falhas);
        setFalhasPageNumber(falhas.number ?? 0);
      } catch (error) {
        console.error("Erro ao carregar dashboard:", error);
      } finally {
        setLoading(false);
      }
    }

    loadAll();
  }, []);

  async function changeFalhaPage(newPage: number) {
    if (!falhasPage) return;
    if (newPage < 0) return;
    const totalPages = falhasPage.totalPages ?? 1;
    if (newPage >= totalPages) return;

    try {
      const falhas = await getFalhas(undefined, newPage, 10);
      setFalhasPage(falhas);
      setFalhasPageNumber(falhas.number ?? newPage);
    } catch (error) {
      console.error("Erro ao paginar falhas:", error);
    }
  }

  return {
    compressor,
    ultimoComando,
    dadosAtuais,
    dadosHistorico,
    falhasPage,
    falhasPageNumber,
    loading,
    changeFalhaPage,
  };
}
