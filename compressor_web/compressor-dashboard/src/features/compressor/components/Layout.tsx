type LayoutProps = {
  children: React.ReactNode;
  header: React.ReactNode;
};

export function Layout({ children, header }: LayoutProps) {
  return (
    <div className="min-h-screen bg-gradient-to-b from-black via-[#0d0d0d] to-black text-slate-100">
      
      <header
        className="
          px-6 py-6
          bg-gradient-to-b from-[#1a1a1a] to-[#0a0a0a]
          border-b border-red-600/50
          shadow-[0_0_25px_rgba(255,0,0,0.35)]
        "
      >
        <div className="max-w-7xl mx-auto">{header}</div>
      </header>

      <main className="max-w-7xl mx-auto px-6 py-16 space-y-16">
        {children}
      </main>
    </div>
  );
}
