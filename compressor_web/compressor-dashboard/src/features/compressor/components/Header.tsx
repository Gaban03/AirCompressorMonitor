import type { Compressor } from "../types";

type HeaderProps = {
  compressor: Compressor | null;
  estado: string | null; // "ALIVIO", "STANDBY", etc.
};

export function Header({ compressor, estado }: HeaderProps) {
  const ligado = compressor?.ligado ?? null;

  const estadoFormatado = estado
    ? estado.charAt(0).toUpperCase() + estado.slice(1).toLowerCase()
    : "Carregando...";

  const estadoCor = (() => {
    switch (estado?.toUpperCase()) {
      case "DESLIGADO":
        return "bg-gray-400";
      case "PARTINDO":
        return "bg-orange-400";
      case "ALIVIO":
      case "ALÍVIO":
        return "bg-blue-400";
      case "EMCARGA":
        return "bg-green-400";
      case "STANDBY":
        return "bg-amber-400";
      case "PARANDO":
        return "bg-orange-600";
      case "DESCONHECIDO":
      default:
        return "bg-neutral-400";
    }
  })();

  const ligadoLabel =
    ligado === null ? "Carregando..." : ligado ? "Ligado" : "Desligado";

  const ligadoClasses =
    ligado === null
      ? "bg-zinc-700/60 border-zinc-500/40 text-zinc-200"
      : ligado
      ? "bg-emerald-500/15 border-emerald-400/60 text-emerald-300"
      : "bg-red-500/20 border-red-400/60 text-red-300";

  const ligadoDotClasses =
    ligado === null
      ? "bg-zinc-300"
      : ligado
      ? "bg-emerald-300"
      : "bg-red-300";

  return (
    <div className="flex w-full items-center justify-center">
      <div className="flex flex-col items-center gap-3 text-center">
        {/* Título */}
        <h1 className="text-[25px] font-extrabold tracking-[0.20em] text-slate-50">
          COMPRESSOR METALPLAN 
        </h1>

        {/* Pills de status */}
        <div className="mt-1 flex flex-wrap items-center justify-center gap-5">
          {/* Ligado / Desligado */}
          <div
            className={`
              flex items-center gap-2 rounded-full px-5 py-1 text- font-semibold
              bg-gradient-to-r from-[#151515] to-[#050505]
              shadow-[0_0_14px_rgba(0,0,0,0.7)]
              ${ligadoClasses}
            `}
          >
            <span className={`h-2 w-2 rounded-full ${ligadoDotClasses}`} />
            <span>{ligadoLabel}</span>
          </div>

          {/* Estado (Running, Alívio, etc) – sem neon */}
          <div
            className="
              flex items-center gap-2 rounded-full px-4 py-1 text- font-semibold
              bg-[#151515]
              border border-zinc-700
              shadow-[0_0_6px_rgba(0,0,0,0.7)]
            "
          >
            <span className={`h-2 w-2 rounded-full ${estadoCor}`} />
            <span className="text-slate-100">{estadoFormatado}</span>
          </div>
        </div>
      </div>
    </div>
  );
}
