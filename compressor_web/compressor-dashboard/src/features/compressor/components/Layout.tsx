type LayoutProps = {
  children: React.ReactNode;
  header: React.ReactNode;
};

export function Layout({ children, header }: LayoutProps) {
  return (
    <div className="min-h-screen bg-gradient-to-b from-black via-[#050506] to-black text-slate-100">
      {/* Barra superior */}
      <header
        className="
          border-b border-red-600/40
          bg-gradient-to-b from-[#111111] via-[#050505] to-[#050505]
          shadow-[0_0_22px_rgba(255,0,0,0.28)]
        "
      >
        <div
          className="
            mx-auto flex w-full
            max-w-7xl 2xl:max-w-[1500px]
            items-center justify-center
            px-6 py-5
          "
        >
          {header}
        </div>
      </header>

      {/* Conteúdo */}
      <main
        className="
          mx-auto flex w-full flex-col gap-6
          max-w-7xl 2xl:max-w-[2000px]
          px-6 py-6
        "
      >
        {children}
      </main>
    </div>
  );
}
