import { Spinner } from "../../../shared/components/Spinner";
import { AlertsTable } from "../components/AlertsTable";
import { FailuresTable } from "../components/FailuresTable";
import { Header } from "../components/Header";
import { HistoryChart } from "../components/HistoryChart";
import { Layout } from "../components/Layout";
import { MaintenanceCard } from "../components/MaintenanceCard";
import { StatusCards } from "../components/StatusCards";
import { useCompressorDashboard } from "../hooks/useCompressorDashboard";

export function CompressorDashboardPage() {
  const {
    compressor,
    dadosAtuais,
    dadosHistorico,
    falhasPage,
    alertasPage,
    falhasPageNumber,
    alertasPageNumber,
    loading,
    changeFalhaPage,
    changeAlertasPage,
  } = useCompressorDashboard();

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gradient-to-b from-black via-zinc-900 to-black">
        <Spinner label="Carregando dashboard..." />
      </div>
    );
  }

  const header = (
    <Header compressor={compressor} estado={dadosAtuais?.estado ?? null} />
  );

  return (
    <Layout header={header}>
      {/* Mobile: 1 coluna  |  Desktop: 3 colunas (esq: manutenção, meio: dados, dir: falhas/alertas) */}
      <div
        className="
          grid gap-6
          lg:[grid-template-columns:minmax(0,1fr)_minmax(0,2fr)_minmax(0,1fr)]
        "
      >
        {/* Coluna ESQUERDA – Manutenções */}
        <div className="space-y-6">
          <MaintenanceCard horasTotais={dadosAtuais?.horaTotal ?? null} />
        </div>

        {/* Coluna MEIO – Status + Gráfico */}
        <div className="space-y-6">
          <StatusCards dadosAtuais={dadosAtuais} />
          <HistoryChart dadosHistorico={dadosHistorico} />
        </div>

        {/* Coluna DIREITA – Falhas + Alertas */}
        <div className="space-y-6">
          <FailuresTable
            falhasPage={falhasPage}
            page={falhasPageNumber}
            onChangePage={changeFalhaPage}
          />

          <AlertsTable
            alertasPage={alertasPage}
            page={alertasPageNumber}
            onChangePage={changeAlertasPage}
          />
        </div>
      </div>
    </Layout>
  );
}
