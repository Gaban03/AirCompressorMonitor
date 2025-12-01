type SpinnerProps = {
  label?: string;
  className?: string;
};

export function Spinner({ label = "Carregando...", className = "" }: SpinnerProps) {
  return (
    <div className={`flex items-center gap-2 text-slate-600 ${className}`}>
      <span className="h-4 w-4 animate-spin rounded-full border-2 border-slate-400 border-t-transparent" />
      <span className="text-sm">{label}</span>
    </div>
  );
}
