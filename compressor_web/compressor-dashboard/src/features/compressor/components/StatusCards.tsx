import type { CompressorDadosResponseDTO } from "../types";
import { Card } from "../../../shared/components/Card";
import {
  formatTemperature,
  formatPressure,
  formatHours,
} from "../../../shared/lib/formatters";

type StatusCardsProps = {
  dadosAtuais: CompressorDadosResponseDTO | null;
};

export function StatusCards({ dadosAtuais }: StatusCardsProps) {
  return (
    <div
      className="
        grid gap-5
        grid-cols-1
        sm:grid-cols-2
        md:grid-cols-3
        lg:grid-cols-4
        xl:grid-cols-5
      "
    >
      <Card title="Temp. Ar Comprimido">
        <span className="text-lg font-semibold text-slate-50">
          {formatTemperature(dadosAtuais?.temperaturaArComprimido)}
        </span>
      </Card>

      <Card title="Temp. Ambiente">
        <span className="text-lg font-semibold text-slate-50">
          {formatTemperature(dadosAtuais?.temperaturaAmbiente)}
        </span>
      </Card>

      <Card title="Pressão do Ar">
        <span className="text-lg font-semibold text-slate-50">
          {formatPressure(dadosAtuais?.pressaoArComprimido)}
        </span>
      </Card>

      <Card title="Horas em Carga">
        <span className="text-lg font-semibold text-slate-50">
          {formatHours(dadosAtuais?.horaCarga)}
        </span>
      </Card>

      <Card title="Horas Totais">
        <span className="text-lg font-semibold text-slate-50">
          {formatHours(dadosAtuais?.horaTotal)}
        </span>
      </Card>

      <Card title="Temp. Óleo">
        <span className="text-lg font-semibold text-slate-50">
          {formatTemperature(dadosAtuais?.temperaturaOleo)}
        </span>
      </Card>

      <Card title="Temp. Orvalho">
        <span className="text-lg font-semibold text-slate-50">
          {formatTemperature(dadosAtuais?.temperaturaOrvalho)}
        </span>
      </Card>

      <Card title="Pressão de Carga">
        <span className="text-lg font-semibold text-slate-50">
          {formatPressure(dadosAtuais?.pressaoCarga)}
        </span>
      </Card>

      <Card title="Pressão de Alívio">
        <span className="text-lg font-semibold text-slate-50">
          {formatPressure(dadosAtuais?.pressaoAlivio)}
        </span>
      </Card>
    </div>
  );
}