import { Spinner } from "../../../shared/components/Spinner";
import { AlertsTable } from "../components/AlertsTable";
import { FailuresTable } from "../components/FailuresTable";
import { Header } from "../components/Header";
import { HistoryChart } from "../components/HistoryChart";
import { Layout } from "../components/Layout";
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
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-b from-black via-zinc-900 to-black">
        <Spinner label="Carregando dashboard..." />
      </div>
    );
  }

  const header = (
    <Header
      compressor={compressor}
      estado={dadosAtuais?.estado ?? null}
    />
  );

  return (
    <Layout header={header}>
      <div className="grid gap-4 lg:grid-cols-[minmax(0,2fr)_minmax(0,1fr)]">

        {/* Esquerda */}
        <div className="space-y-4">
          <StatusCards dadosAtuais={dadosAtuais} />
          <HistoryChart dadosHistorico={dadosHistorico} />
        </div>

        {/* Direita */}
        <div className="space-y-4">
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
