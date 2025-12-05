type CompressorStatusProps = {
  ligado: boolean | null;
};

export function CompressorStatusCard({ ligado }: CompressorStatusProps) {
  const status = ligado ? "Ligado" : "Desligado";

  const color = ligado
    ? "bg-emerald-500/20 border-emerald-400/40 text-emerald-300"
    : "bg-red-500/20 border-red-400/40 text-red-300";

  const dot = ligado ? "bg-emerald-300" : "bg-red-300";

  return (
    <div
      className={`
        rounded-xl p-5
        bg-gradient-to-br from-[#151515] via-[#0e0e0e] to-black
        border ${ligado ? "border-emerald-500/40" : "border-red-500/40"}
        shadow-[0_4px_12px_rgba(0,0,0,0.5)]
      `}
    >
      <div className="text-xs font-semibold uppercase tracking-widest text-red-400/80 mb-2">
        Status do Compressor
      </div>

      <div className={`flex items-center gap-3 rounded-full px-4 py-1 ${color}`}>
        <span className={`h-2 w-2 rounded-full ${dot}`} />
        <span className="text-lg font-semibold">{status}</span>
      </div>
    </div>
  );
}
