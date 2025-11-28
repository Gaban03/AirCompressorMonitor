type CardProps = {
  title: string;
  children: React.ReactNode;
};

export function Card({ title, children }: CardProps) {
  return (
    <div
      className="
        rounded-xl
        p-5
        bg-gradient-to-br from-[#1a1a1a] via-[#111] to-[#0a0a0a]
        border border-red-600/70
        shadow-[0_6px_15px_rgba(255,0,0,0.20)]
        hover:shadow-[0_8px_25px_rgba(255,0,0,0.35)]
        hover:-translate-y-1
        transition-all
        duration-300
      "
    >
      <div className="text-xs font-semibold uppercase tracking-widest text-red-400 mb-2">
        {title}
      </div>

      <div className="text-slate-200 text-sm">
        {children}
      </div>
    </div>
  );
}
