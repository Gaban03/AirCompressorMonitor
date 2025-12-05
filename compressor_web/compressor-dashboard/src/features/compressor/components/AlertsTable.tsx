import type { AlertasPageDTO } from "../types";
import { Card } from "../../../shared/components/Card";
import { formatDateTimeShort } from "../../../shared/lib/formatters";

type AlertsTableProps = {
  alertasPage: AlertasPageDTO | null;
  page: number;
  onChangePage: (newPage: number) => void;
};

export function AlertsTable({
  alertasPage,
  page,
  onChangePage,
}: AlertsTableProps) {
  const totalPages = alertasPage?.totalPages ?? 0;
  const hasContent = alertasPage?.content && alertasPage.content.length > 0;

  return (
    <Card title="Alertas Recentes">
      {!hasContent ? (
        <p className="text-slate-400">Nenhum alerta registrado.</p>
      ) : (
        <>
          <div className="overflow-x-auto">
            <table className="min-w-full text-xs sm:text-sm">
              <thead>
                <tr className="border-b border-red-500/40 bg-zinc-900/80">
                  <th className="px-3 py-2 text-left font-semibold text-red-300">
                    Descrição
                  </th>
                  <th className="px-3 py-2 text-right font-semibold text-red-300">
                    Horário
                  </th>
                </tr>
              </thead>

              <tbody>
                {alertasPage!.content!.map((alerta) => (
                  <tr
                    key={alerta.id}
                    className="border-b border-zinc-800 hover:bg-zinc-900/60 transition"
                  >
                    <td className="px-3 py-2 text-slate-100">
                      {alerta.descricao ?? "-"}
                    </td>
                    <td className="px-3 py-2 text-right text-slate-300">
                      {formatDateTimeShort(alerta.horario)}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          <div className="mt-3 flex items-center justify-between text-[11px] text-slate-300">
            <button
              onClick={() => onChangePage(page - 1)}
              className="rounded-full border border-red-500/60 px-3 py-1 hover:bg-red-500/10 disabled:opacity-40"
              disabled={page <= 0}
            >
              {"<"} Anterior
            </button>

            <span>
              Página <b>{page + 1}</b> de {totalPages}
            </span>

            <button
              onClick={() => onChangePage(page + 1)}
              className="rounded-full border border-red-500/60 px-3 py-1 hover:bg-red-500/10 disabled:opacity-40"
              disabled={page >= totalPages - 1}
            >
              Próxima {">"}
            </button>
          </div>
        </>
      )}
    </Card>
  );
}
