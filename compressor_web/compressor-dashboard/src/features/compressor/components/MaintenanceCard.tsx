import { Card } from "../../../shared/components/Card";

type MaintenanceItem = {
  id: string;
  nome: string;
  intervalos: number[]; // horas em que a manutenção é prevista
};

// Tabela baseada na foto da “TABELA DE REVISÕES PERIÓDICAS”
const MAINTENANCE_ITEMS: MaintenanceItem[] = [
  {
    id: "filtro_oleo",
    nome: "Filtro de óleo",
    intervalos: [500, 2000, 4000, 6000, 8000, 10000, 12000, 14000, 16000, 18000, 20000],
  },
  {
    id: "filtro_admissao",
    nome: "Filtro de admissão",
    intervalos: [500, 2000, 4000, 6000, 8000, 10000, 12000, 14000, 16000, 18000, 20000],
  },
  {
    id: "separador_ar_oleo",
    nome: "Separador de ar/óleo",
    intervalos: [2000, 4000, 8000, 12000, 16000, 20000],
  },
  {
    id: "lubrificante_rotor",
    nome: "Lubrificante ROTOR OIL EXTRA",
    intervalos: [2000, 4000, 6000, 8000, 10000, 12000, 14000, 16000, 18000, 20000],
  },
  {
    id: "correias",
    nome: "Correias de transmissão",
    intervalos: [4000, 8000, 12000, 16000, 20000],
  },
  {
    id: "kit_valvula_admissao",
    nome: "Kit de reparo da válvula admissão",
    intervalos: [8000, 16000],
  },
  {
    id: "kit_valvula_termostatica",
    nome: "Kit de reparo da válvula termostática",
    intervalos: [8000, 16000],
  },
  {
    id: "kit_valvula_pressao_minima",
    nome: "Kit de reparo da válvula de pressão mínima",
    intervalos: [8000, 16000],
  },
  {
    id: "revisao_unidade",
    nome: "Revisão da unidade compressora",
    intervalos: [20000],
  },
];

type StatusCalc = {
  proxima: number | null;
  faltam: number | null;
  label: string;
  colorClass: string;
  progressPercent: number; // 0–100
};

// Calcula próxima revisão, horas faltando e status (Normal / Atenção / Alerta)
function calcularStatus(
  horasTotais: number,
  item: MaintenanceItem
): StatusCalc {
  if (!item.intervalos.length) {
    return {
      proxima: null,
      faltam: null,
      label: "Sem intervalo configurado",
      colorClass: "text-slate-300",
      progressPercent: 0,
    };
  }

  const ordenados = [...item.intervalos].sort((a, b) => a - b);

  // próximo ponto de manutenção >= horas atuais
  const proxima = ordenados.find((h) => h >= horasTotais) ?? null;

  // se já passou de todos, considera última como “referência” e está atrasado
  if (!proxima) {
    const last = ordenados[ordenados.length - 1];
    const atraso = horasTotais - last;

    return {
      proxima: last,
      faltam: -atraso,
      label: `ALERTA: troca de ${item.nome} atrasada em ${atraso.toFixed(0)}h`,
      colorClass: "text-red-400",
      progressPercent: 100,
    };
  }

  const faltam = proxima - horasTotais; // pode ser 0 quando bate exato
  const progressPercent = Math.min(
    100,
    Math.max(0, (horasTotais / proxima) * 100)
  );

  let label: string;
  let colorClass: string;

  if (faltam <= 0) {
    label = `ALERTA: troca de ${item.nome} necessária`;
    colorClass = "text-slate-100";
  } else if (faltam <= 100) {
    label = `Atenção: faltam ${faltam.toFixed(0)}h`;
    colorClass = "text-slate-100"; 
  } else {
    label = `Faltam ${faltam.toFixed(0)}h`;
    colorClass = "text-slate-100"; 
  }


  return {
    proxima,
    faltam,
    label,
    colorClass,
    progressPercent,
  };
}

type MaintenanceCardProps = {
  horasTotais: number | null; // vem de dadosAtuais.horaTotal
};

export function MaintenanceCard({ horasTotais }: MaintenanceCardProps) {
  return (
    <Card title="Manutenções (horas)">
      {horasTotais == null ? (
        <p className="text-slate-400 text-sm">Carregando horas totais...</p>
      ) : (
        <div className="space-y-4">
          {MAINTENANCE_ITEMS.map((item) => {
            const status = calcularStatus(horasTotais, item);

            return (
              <div key={item.id} className="flex flex-col gap-1">
                {/* Nome do componente */}
                <span className="text-[11px] uppercase tracking-[0.25em] text-red-300">
                  {item.nome}
                </span>

                {/* Linha principal de status */}
                <div className="flex items-center justify-between text-xs sm:text-sm">
                  <span className={status.colorClass + " font-semibold"}>
                    {status.label}
                  </span>

                  {status.proxima && (
                    <span className="text-[11px] text-slate-400">
                      Próxima: {status.proxima}h
                    </span>
                  )}
                </div>

                {/* Barra de progresso */}
                {status.proxima && (
                  <div className="mt-1 h-2 w-full rounded-full bg-red-900/40 overflow-hidden">
                    <div
                      className={`
                        h-2 rounded-full
                        ${status.faltam !== null && status.faltam <= 0
                          ? "bg-red-500"
                          : status.faltam !== null && status.faltam <= 100
                            ? "bg-amber-400"
                            : "bg-emerald-400"
                        }
                      `}
                      style={{ width: `${status.progressPercent}%` }}
                    />
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}
    </Card>
  );
}
