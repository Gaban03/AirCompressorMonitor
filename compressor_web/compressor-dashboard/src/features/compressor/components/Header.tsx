import type { Compressor } from "../types";

type HeaderProps = {
  compressor: Compressor | null;
  estado: string | null; // recebe o ESTADO real da API: "ALIVIO", "STANDBY", etc.
};

export function Header({ estado }: HeaderProps) {

  const estadoFormatado = estado
    ? estado.charAt(0).toUpperCase() + estado.slice(1).toLowerCase()
    : "Carregando...";

  // Paleta de cor por estado
  const estadoCor = (() => {
    switch (estado?.toUpperCase()) {
      case "LIGADO":
        return "bg-emerald-500";
      case "EM CARGA":
      case "CARGA":
        return "bg-yellow-400";
      case "ALIVIO":
      case "ALÍVIO":
        return "bg-blue-400";
      case "STANDBY":
        return "bg-yellow-500";
      case "DESLIGANDO":
        return "bg-orange-400";
      case "DESLIGADO":
        return "bg-red-500";
      default:
        return "bg-gray-400";
    }
  })();

  return (
    <div className="flex items-center justify-center w-full">
      
      <div className="flex flex-col items-center">
        <h1 className="text-2xl font-extrabold tracking-widest text-slate-100">
          SENAI
        </h1>

        <div
          className="
            mt-1 px-4 py-1 rounded-full text-xs 
            flex items-center gap-2
            bg-gradient-to-r from-[#242424] to-[#151515]
            border border-red-500/60
            shadow-[0_0_10px_rgba(255,0,0,0.25)]
          "
        >
          <span className={`h-2 w-2 rounded-full ${estadoCor}`} />

          <span className="text-slate-200 font-semibold">
            {estadoFormatado}
          </span>
        </div>
      </div>

      <div className="w-6" />
    </div>
  );
}
