import type { PageFalhasDTO } from "../types";
import { Card } from "../../../shared/components/Card";
import { formatDateTimeShort } from "../../../shared/lib/formatters";

type FailuresTableProps = {
  falhasPage: PageFalhasDTO | null;
  page: number;
  onChangePage: (newPage: number) => void;
};

export function FailuresTable({ falhasPage, page, onChangePage }: FailuresTableProps) {
  return (
    <Card title="Falhas Recentes">
      {!falhasPage?.content?.length ? (
        <p className="text-slate-400">Nenhuma falha registrada.</p>
      ) : (
        <>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-[#141414] border-b border-red-500/40">
                  <th className="text-left px-3 py-2">Descrição</th>
                  <th className="text-right px-3 py-2">Horário</th>
                </tr>
              </thead>

              <tbody>
                {falhasPage.content.map((f) => (
                  <tr
                    key={f.id}
                    className="hover:bg-[#1a1a1a] border-b border-zinc-800"
                  >
                    <td className="px-3 py-2">{f.descricao}</td>
                    <td className="px-3 py-2 text-right">{formatDateTimeShort(f.horario)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          <div className="mt-4 flex justify-between items-center text-xs text-slate-300">
            <button
              onClick={() => onChangePage(page - 1)}
              className="px-3 py-1 rounded-full border border-red-500/60 hover:bg-red-500/10 disabled:opacity-40"
              disabled={page <= 0}
            >
              {"< Anterior"}
            </button>

            <span>
              Página <b>{page + 1}</b> de {falhasPage?.totalPages ?? 1}
            </span>

            <button
              onClick={() => onChangePage(page + 1)}
              className="px-3 py-1 rounded-full border border-red-500/60 hover:bg-red-500/10 disabled:opacity-40"
              disabled={page >= (falhasPage?.totalPages ?? 1) - 1}
            >
              {"Próxima >"}
            </button>
          </div>
        </>
      )}
    </Card>
  );
}
