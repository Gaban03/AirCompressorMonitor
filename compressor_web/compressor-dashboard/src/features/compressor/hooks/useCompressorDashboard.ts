import { useEffect, useState } from "react";
import {
  getCompressorLigado,
  getUltimoComando,
  getUltimosDadosSensores,
  getDadosDashboard,
  getFalhas,
  getAlertas,
} from "../api/compressorApi";

import type {
  ComandoResponseDTO,
  Compressor,
  CompressorDadosResponseDTO,
  PageFalhasDTO,
  AlertasPageDTO,
} from "../types";

export function useCompressorDashboard() {
  const [compressor, setCompressor] = useState<Compressor | null>(null);
  const [ultimoComando, setUltimoComando] = useState<ComandoResponseDTO | null>(null);
  const [dadosAtuais, setDadosAtuais] = useState<CompressorDadosResponseDTO | null>(null);
  const [dadosHistorico, setDadosHistorico] = useState<CompressorDadosResponseDTO[]>([]);
  const [falhasPage, setFalhasPage] = useState<PageFalhasDTO | null>(null);
  const [alertasPage, setAlertasPage] = useState<AlertasPageDTO | null>(null);
  const [falhasPageNumber, setFalhasPageNumber] = useState(0);
  const [alertasPageNumber, setAlertasPageNumber] = useState(0);
  const [loading, setLoading] = useState(true);

  async function loadAll() {
    try {
      const [
        comp,
        comando,
        dados,
        historico,
        falhas,
        alertas,
      ] = await Promise.all([
        getCompressorLigado(),
        getUltimoComando(),
        getUltimosDadosSensores(),
        getDadosDashboard(),
        getFalhas(undefined, 0, 10),
        getAlertas(undefined, 0, 10),
      ]);

      setCompressor(comp);
      setUltimoComando(comando);
      setDadosAtuais(dados);
      setDadosHistorico(historico);
      setFalhasPage(falhas);
      setAlertasPage(alertas);
      setFalhasPageNumber(falhas.number ?? 0);
      setAlertasPageNumber(alertas.number ?? 0);
    } catch (error) {
      console.error("Erro ao carregar dashboard:", error);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    // primeiro load
    loadAll();
    // pooling a cada 30s
    const interval = setInterval(loadAll, 30000);
    return () => clearInterval(interval);
  }, []);

  async function changeFalhaPage(newPage: number) {
    if (!falhasPage) return;
    if (newPage < 0) return;
    if (newPage >= (falhasPage.totalPages ?? 1)) return;

    try {
      const result = await getFalhas(undefined, newPage, 10);
      setFalhasPage(result);
      setFalhasPageNumber(result.number ?? newPage);
    } catch (e) {
      console.error("Erro ao paginar falhas:", e);
    }
  }

  async function changeAlertasPage(newPage: number) {
    if (!alertasPage) return;
    if (newPage < 0) return;
    if (newPage >= (alertasPage.totalPages ?? 1)) return;

    try {
      const result = await getAlertas(undefined, newPage, 10);
      setAlertasPage(result);
      setAlertasPageNumber(result.number ?? newPage);
    } catch (e) {
      console.error("Erro ao paginar alertas:", e);
    }
  }

  return {
    compressor,
    ultimoComando,
    dadosAtuais,
    dadosHistorico,
    falhasPage,
    alertasPage,
    falhasPageNumber,
    alertasPageNumber,
    loading,
    changeFalhaPage,
    changeAlertasPage,
  };
}
