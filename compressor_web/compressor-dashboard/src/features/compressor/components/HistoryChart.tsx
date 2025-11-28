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
} from "recharts";
import { formatDateTimeShort } from "../../../shared/lib/formatters";

type Props = {
  dadosHistorico: CompressorDadosResponseDTO[];
};

export function HistoryChart({ dadosHistorico }: Props) {
  const data = dadosHistorico.map((d) => ({
    name: formatDateTimeShort(d.dataHora),
    pressao: d.pressaoArComprimido,
    temperatura: d.temperaturaArComprimido,
  }));

  return (
    <Card title="Últimos Dados">
      {data.length === 0 ? (
        <p className="text-slate-400">Sem dados recentes.</p>
      ) : (
        <div className="w-full h-64">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={data} margin={{ top: 10, right: 20, left: 0, bottom: 10 }}>
              <CartesianGrid strokeOpacity={0.1} stroke="#ff0000" />
              <XAxis
                dataKey="name"
                stroke="#e2e8f0"
                tick={{ fontSize: 10 }}
              />
              <YAxis
                stroke="#e2e8f0"
                tick={{ fontSize: 10 }}
              />
              <Tooltip
                contentStyle={{
                  backgroundColor: "#111",
                  border: "1px solid #f00",
                  borderRadius: "10px",
                }}
                labelStyle={{ color: "#fff" }}
              />
              <Line
                type="monotone"
                dataKey="pressao"
                stroke="#ff4747"
                strokeWidth={3}
                dot={{ stroke: "#ff0000", strokeWidth: 2, r: 4 }}
                activeDot={{ r: 6 }}
              />
              <Line
                type="monotone"
                dataKey="temperatura"
                stroke="#38bdf8"
                strokeWidth={3}
                dot={{ stroke: "#38bdf8", strokeWidth: 2, r: 4 }}
                activeDot={{ r: 6 }}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
      )}
    </Card>
  );
}
