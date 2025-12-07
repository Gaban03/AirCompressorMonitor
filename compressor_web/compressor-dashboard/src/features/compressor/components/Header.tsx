import { useState } from "react";
import type { Compressor } from "../types";
import { FaGithub, FaLinkedin } from "react-icons/fa";

type HeaderProps = {
  compressor: Compressor | null;
  estado: string | null;
};

type Developer = {
  nome: string;
  papel: string;
  email: string;
  github?: string;
  linkedin?: string;
};

const DEVELOPERS: Developer[] = [
  {
    nome: "Murilo Herrick Riva de Camargo",
    papel: "Frontend(web) / Backend(API - Spring Boot) ",
    email: "muriloherrick@gmail.com",
    github: "https://github.com/Murilo-Herrick",
    linkedin: "https://www.linkedin.com/in/murilo-herrick-571a93334/",
  },
  {
    nome: "Nicolas Moreira Ribeiro",
    papel: "IoT / Infraestrutura",
    email: "nicolas@email.com",
    github: "https://github.com/NicolasRibe",
    linkedin:
      "https://www.linkedin.com/in/nicolas-moreira-ribeiro-37a139181/",
  },
  {
    nome: "Vinicius Brolezzi Gaban",
    papel: "Frontend(mobile) / UI",
    email: "gabanvinicius724@gmail.com",
    github: "https://github.com/Gaban03",
    linkedin: "https://www.linkedin.com/in/vinicius-gaban/",
  },
];

export function Header({ compressor, estado }: HeaderProps) {
  const [showInfo, setShowInfo] = useState(false);

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
    <div className="relative flex w-full items-center justify-center">

      {/* Botão de Info — center-right */}
      <button
        type="button"
        onClick={() => setShowInfo((prev) => !prev)}
        className="
          absolute right-0 top-1/2 -translate-y-1/2 z-40
          inline-flex h-10 w-10 items-center justify-center
          rounded-full
          bg-black/60 text-red-300
          hover:bg-red-500/20 hover:text-red-200
          transition
        "
        aria-label="Informações sobre o sistema"
      >
        <svg viewBox="0 0 24 24" className="h-4 w-4" aria-hidden="true">
          <circle cx="12" cy="12" r="10" className="stroke-current" fill="none" strokeWidth="1.5" />
          <line x1="12" y1="10" x2="12" y2="16" className="stroke-current" strokeWidth="1.5" strokeLinecap="round" />
          <circle cx="12" cy="7" r="0.9" className="fill-current" />
        </svg>
      </button>

      {/* Conteúdo principal */}
      <div className="flex flex-col items-center gap-3 text-center">
        <h1 className="text-[25px] font-extrabold tracking-[0.20em] text-slate-50">
          COMPRESSOR METALPLAN
        </h1>

        <div className="mt-1 flex flex-wrap items-center justify-center gap-5">

          {/* Ligado / Desligado */}
          <div
            className={`
              flex items-center gap-2 rounded-full px-5 py-1 text-sm font-semibold
              bg-gradient-to-r from-[#151515] to-[#050505]
              shadow-[0_0_14px_rgba(0,0,0,0.7)]
              ${ligadoClasses}
            `}
          >
            <span className={`h-2 w-2 rounded-full ${ligadoDotClasses}`} />
            <span>{ligadoLabel}</span>
          </div>

          {/* Estado */}
          <div
            className="
              flex items-center gap-2 rounded-full px-4 py-1 text-sm font-semibold
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

      {/* Overlay que fecha ao clicar fora */}
      {showInfo && (
        <div
          className="fixed inset-0 z-20"
          onClick={() => setShowInfo(false)}
        />
      )}

      {/* Painel de Informações */}
      {showInfo && (
        <div
          className="
            absolute right-0 top-1/2 translate-y-4 z-30
            w-[420px] max-w-[90vw]
            rounded-2xl border border-red-600/60
            bg-gradient-to-br from-[#151515] via-[#050505] to-black
            p-5 shadow-[0_0_22px_rgba(0,0,0,0.9)]
          "
        >
          <p className="mb-3 text-[15px] font-semibold uppercase tracking-[0.25em] text-red-400">
            Desenvolvido por
          </p>

          <div className="space-y-5 text-left">
            {DEVELOPERS.map((dev) => (
              <div
                key={dev.email + dev.nome}
                className="
                  rounded-xl border border-red-500/25 bg-black/40
                  px-4 py-4
                "
              >
                <div className="text-m font-semibold text-slate-100">{dev.nome}</div>
                <div className="text-[14px] text-red-300">{dev.papel}</div>
                <div className="mt-1 text-[13px] text-slate-400">{dev.email}</div>

                {/* Ícones sociais — react-icons */}
                <div className="mt-2 flex items-center gap-3 text-[13px] text-slate-300">

                  {dev.github && (
                    <a
                      href={dev.github}
                      target="_blank"
                      rel="noreferrer"
                      className="flex items-center gap-1 hover:text-white transition"
                    >
                      <FaGithub className="h-5 w-5" />
                      <span>GitHub</span>
                    </a>
                  )}

                  {dev.linkedin && (
                    <a
                      href={dev.linkedin}
                      target="_blank"
                      rel="noreferrer"
                      className="flex items-center gap-1 hover:text-white transition"
                    >
                      <FaLinkedin className="h-5 w-5" />
                      <span>LinkedIn</span>
                    </a>
                  )}

                </div>
              </div>
            ))}
          </div>
        </div>
      )}

    </div>
  );
}
