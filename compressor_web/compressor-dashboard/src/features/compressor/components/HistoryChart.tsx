import { useState } from "react";
import type { CompressorDadosResponseDTO } from "../types";
import { Card } from "../../../shared/components/Card";
import {
  LineChart,
  Line,
  ResponsiveContainer,
  XAxis,
  YAxis,
  Tooltip,
  CartesianGrid,
  Legend,
} from "recharts";
import { formatDateTimeShort } from "../../../shared/lib/formatters";

type HistoryChartProps = {
  dadosHistorico: CompressorDadosResponseDTO[];
};

type TabKey = "temperaturas" | "pressoes";

const TEMPERATURE_SERIES = [
  {
    key: "temperaturaArComprimido",
    label: "Temp. Ar comprimido",
    color: "#38bdf8",
  },
  {
    key: "temperaturaAmbiente",
    label: "Temp. ambiente",
    color: "#22c55e",
  },
  {
    key: "temperaturaOleo",
    label: "Temp. óleo",
    color: "#f97373",
  },
  {
    key: "temperaturaOrvalho",
    label: "Temp. orvalho",
    color: "#a855f7",
  },
] as const;

const PRESSURE_SERIES = [
  {
    key: "pressaoArComprimido",
    label: "Pressão do ar",
    color: "#fb923c",
  },
  {
    key: "pressaoCarga",
    label: "Pressão de carga",
    color: "#f97316",
  },
  {
    key: "pressaoAlivio",
    label: "Pressão de alívio",
    color: "#eab308",
  },
] as const;

export function HistoryChart({ dadosHistorico }: HistoryChartProps) {
  const [activeTab, setActiveTab] = useState<TabKey>("temperaturas");

  if (!dadosHistorico || dadosHistorico.length === 0) {
    return (
      <Card title="Últimos dados">
        <p className="text-sm text-slate-400">Sem dados recentes.</p>
      </Card>
    );
  }

  // ordena por data (mais antigo -> mais recente) e formata o label do eixo X
  const data = [...dadosHistorico]
    .sort(
      (a, b) =>
        new Date(a.dataHora ?? 0).getTime() -
        new Date(b.dataHora ?? 0).getTime()
    )
    .map((d) => ({
      ...d,
      label: d.dataHora ? formatDateTimeShort(d.dataHora) : "—",
    }));

  const series = activeTab === "temperaturas"
    ? TEMPERATURE_SERIES
    : PRESSURE_SERIES;

  return (
    <Card title="Últimos dados">
      {/* Abas */}
      <div className="mb-4 flex items-center justify-end">
        <div
          className="
            inline-flex items-center gap-1 rounded-full
            border border-red-600/40 bg-black/60
            px-1 py-1 text-[11px] uppercase tracking-[0.18em]
          "
        >
          <button
            type="button"
            onClick={() => setActiveTab("temperaturas")}
            className={`
              rounded-full px-3 py-1
              transition
              ${activeTab === "temperaturas"
                ? "bg-red-600/70 text-slate-50 shadow-[0_0_10px_rgba(248,113,113,0.45)]"
                : "text-slate-300 hover:text-slate-100"
              }
            `}
          >
            Temperaturas
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("pressoes")}
            className={`
              rounded-full px-3 py-1
              transition
              ${activeTab === "pressoes"
                ? "bg-red-600/70 text-slate-50 shadow-[0_0_10px_rgba(248,113,113,0.45)]"
                : "text-slate-300 hover:text-slate-100"
              }
            `}
          >
            Pressões
          </button>
        </div>
      </div>

      {/* Gráfico */}
      <div className="h-72 w-full">
        <ResponsiveContainer width="100%" height="100%">
          <LineChart data={data} margin={{ top: 10, right: 20, left: 0, bottom: 10 }}>
            <CartesianGrid stroke="#262626" strokeDasharray="3 3" />
            <XAxis
              dataKey="label"
              stroke="#e2e8f0"
              tick={{ fontSize: 10, fill: "#e2e8f0" }}
            />
            <YAxis
              stroke="#e2e8f0"
              tick={{ fontSize: 10, fill: "#e2e8f0" }}
            />
            <Tooltip
              contentStyle={{
                backgroundColor: "#050509",
                border: "1px solid #f87171",
                borderRadius: "10px",
              }}
              labelStyle={{ color: "#e5e7eb" }}
            />
            <Legend
              wrapperStyle={{
                paddingTop: 8,
              }}
            />

            {series.map((serie) => (
              <Line
                key={serie.key}
                type="monotone"
                dataKey={serie.key}
                name={serie.label}
                stroke={serie.color}
                strokeWidth={2}
                dot={false}
                activeDot={{ r: 5 }}
              />
            ))}
          </LineChart>
        </ResponsiveContainer>
      </div>
    </Card>
  );
}
