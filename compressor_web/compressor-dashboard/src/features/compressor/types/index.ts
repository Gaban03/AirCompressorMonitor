export interface ComandoResponseDTO {
  compressorId?: number;
  comando?: boolean;
  dataHora?: string;
}

export interface CompressorDadosResponseDTO {
  dataHora?: string;
  ligado?: boolean;
  estado?: string;
  temperaturaArComprimido?: number;
  temperaturaAmbiente?: number;
  temperaturaOleo?: number;
  temperaturaOrvalho?: number;
  pressaoArComprimido?: number;
  horaCarga?: number;
  horaTotal?: number;
  pressaoCarga?: number;
  pressaoAlivio?: number;
  falhaId?: string;
  falhaDescricao?: string;
}

export interface Compressor {
  id?: number;
  nome: string;
  senai: string;
  ligado?: boolean;
}

export interface FalhasDTO {
  id?: string;
  descricao?: string;
  horario?: string;
}

export interface PageableObject {
  paged?: boolean;
  pageNumber?: number;
  pageSize?: number;
  offset?: number;
}

export interface SortObject {
  sorted?: boolean;
  empty?: boolean;
  unsorted?: boolean;
}

export interface PageFalhasDTO {
  totalElements?: number;
  totalPages?: number;
  pageable?: PageableObject;
  size?: number;
  content?: FalhasDTO[];
  number?: number;
  sort?: SortObject;
  numberOfElements?: number;
  first?: boolean;
  last?: boolean;
  empty?: boolean;
}

export interface AlertasDTO {
  id?: string;
  descricao?: string;
  horario?: string;
}

export interface AlertasPageDTO {
  totalElements?: number;
  totalPages?: number;
  pageable?: PageableObject;
  size?: number;
  content?: AlertasDTO[];
  number?: number;
  sort?: SortObject;
  numberOfElements?: number;
  first?: boolean;
  last?: boolean;
  empty?: boolean;
}

