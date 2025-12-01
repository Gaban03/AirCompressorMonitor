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
    <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">

      <Card title="Temp. Ar Comprimido">
        <span className="text-xl font-bold">{formatTemperature(dadosAtuais?.temperaturaArComprimido)}</span>
      </Card>

      <Card title="Temp. Ambiente">
        <span className="text-xl font-bold">{formatTemperature(dadosAtuais?.temperaturaAmbiente)}</span>
      </Card>

      <Card title="Pressão do Ar">
        <span className="text-xl font-bold">{formatPressure(dadosAtuais?.pressaoArComprimido)}</span>
      </Card>

      <Card title="Horas em carga">
        <span className="text-xl font-bold">{formatHours(dadosAtuais?.horaCarga)}</span>
      </Card>

      <Card title="Horas totais">
        <span className="text-xl font-bold">{formatHours(dadosAtuais?.horaTotal)}</span>
      </Card>
    </div>
  );
}
