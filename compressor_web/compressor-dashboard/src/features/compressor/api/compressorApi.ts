import { api } from "./client";
import { isAxiosError } from "axios";
import type {
  ComandoResponseDTO,
  CompressorDadosResponseDTO,
  Compressor,
  PageFalhasDTO,
} from "../types";

const DEFAULT_COMPRESSOR_ID = 1;

export async function getUltimosDadosSensores(
  idCompressor: number = DEFAULT_COMPRESSOR_ID
): Promise<CompressorDadosResponseDTO> {
  const { data } = await api.get<CompressorDadosResponseDTO>("/compressor/dados", {
    params: { idCompressor },
  });
  return data;
}

export async function getDadosDashboard(
  idCompressor: number = DEFAULT_COMPRESSOR_ID
): Promise<CompressorDadosResponseDTO[]> {
  const { data } = await api.get<CompressorDadosResponseDTO[]>(
    "/compressor/dados-dashboard",
    {
      params: { idCompressor },
    }
  );
  return data;
}

export async function getFalhas(
  idCompressor: number = DEFAULT_COMPRESSOR_ID,
  page: number = 0,
  size: number = 10
): Promise<PageFalhasDTO> {
  const { data } = await api.get<PageFalhasDTO>("/compressor/falhas", {
    params: { idCompressor, page, size },
  });
  return data;
}

export async function getCompressorLigado(
  compressorId: number = DEFAULT_COMPRESSOR_ID
): Promise<Compressor> {
  const { data } = await api.get<Compressor>("/confirmacao/ligado", {
    params: { compressorId },
  });
  return data;
}

export async function getUltimoComando(
  compressorId: number = DEFAULT_COMPRESSOR_ID
): Promise<ComandoResponseDTO | null> {
  try {
    const { data } = await api.get<ComandoResponseDTO>("/ordemRemota/comando", {
      params: { compressorId },
    });
    return data;
  } catch (error) {
    if (isAxiosError(error)) {
      if (error.response?.status === 204) {
        return null;
      }
    }
    throw error;
  }
}
