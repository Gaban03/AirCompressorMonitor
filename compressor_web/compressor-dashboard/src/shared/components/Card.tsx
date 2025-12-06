type CardProps = {
  title: string;
  children: React.ReactNode;
};

export function Card({ title, children }: CardProps) {
  return (
    <div
      className="
        rounded-2xl
        bg-gradient-to-br from-[#121212] via-[#080808] to-black
        border border-red-600/30
        shadow-[0_0_16px_rgba(0,0,0,0.9)]
        hover:shadow-[0_0_22px_rgba(255,0,0,0.40)]
        transition-all duration-300
        p-5
        flex flex-col justify-between
      "
    >
      <div className="mb-2 text-[12px] font-semibold uppercase tracking-[0.50em] text-red-400/85">
        {title}
      </div>

      <div className="text-[13px] text-slate-200 font-medium">{children}</div>
    </div>
  );
}
