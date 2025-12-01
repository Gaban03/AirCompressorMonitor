import { useCompressorDashboard } from "../hooks/useCompressorDashboard";
import { FailuresTable } from "../components/FailuresTable";
import { HistoryChart } from "../components/HistoryChart";
import { StatusCards } from "../components/StatusCards";
import { Layout } from "../components/Layout";
import { Spinner } from "../../../shared/components/Spinner";
import { Header } from "../components/Header";

export function CompressorDashboardPage() {
  const {
    compressor,
    dadosAtuais,
    dadosHistorico,
    falhasPage,
    falhasPageNumber,
    loading,
    changeFalhaPage,
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
        {/* Coluna esquerda */}
        <div className="space-y-4">
          <StatusCards dadosAtuais={dadosAtuais} />
          <HistoryChart dadosHistorico={dadosHistorico} />
        </div>

        {/* Coluna direita */}
        <div>
          <FailuresTable
            falhasPage={falhasPage}
            page={falhasPageNumber}
            onChangePage={changeFalhaPage}
          />
        </div>
      </div>
    </Layout>
  );
}
