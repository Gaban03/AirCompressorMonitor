# 📡 Air Compressor Monitor

O **Air Compressor Monitor** é uma plataforma de **monitoramento e controle remoto de compressor de ar industrial**, desenvolvida como **Projeto Integrador** no curso de **Análise e Desenvolvimento de Sistemas (ADS)**, em parceria com a **Escola SENAI Antonio Adolpho Lobbe**.

O sistema permite acompanhar, em tempo real, as condições operacionais do compressor, apoiar **manutenção preventiva e preditiva** e reduzir falhas e paradas inesperadas, utilizando conceitos de **automação industrial, IoT e desenvolvimento full stack**.

---

## 💡 Motivação

O projeto surgiu a partir de uma **necessidade real da instituição SENAI**: a ausência de um sistema eficiente para acompanhamento do compressor industrial utilizado em suas instalações.

Essa limitação resultava em falhas recorrentes, manutenção reativa e prejuízos operacionais. Diante desse cenário, foi proposta a criação de uma solução capaz de fornecer **dados em tempo real**, **histórico operacional** e **alertas**, contribuindo para maior confiabilidade do equipamento e redução de custos de manutenção.

---

## 🎯 Objetivo

Desenvolver uma plataforma que possibilite:

- Monitoramento em tempo real das variáveis do compressor
- Registro histórico de dados para análise
- Listagem de falhas e alertas operacionais
- Apoio à manutenção preventiva por meio de cargas horárias
- Acesso via **interface web** e **aplicativo mobile**
- Controle remoto e agendamento de operação (mobile)
- Integração com API e banco de dados

---

## 🔧 Funcionalidades do Sistema

- Monitoramento em tempo real das variáveis operacionais do compressor
- Registro e consulta de histórico de dados
- Geração e exibição de falhas e alertas operacionais
- Acompanhamento de cargas horárias para manutenção preventiva
- Dashboards de monitoramento via **interface web**
- Monitoramento e controle remoto via **aplicativo mobile**
- Liga/desliga remoto do compressor
- Agendamento de horários de operação
- Integração com API e banco de dados centralizado

---

## 👥 Público-Alvo

O sistema foi projetado para atender:

- **Técnicos e engenheiros de manutenção**, responsáveis pela operação e confiabilidade do compressor
- **Gestores e coordenadores**, interessados no acompanhamento do desempenho e histórico do equipamento
- **Alunos e professores**, envolvidos em projetos acadêmicos nas áreas de automação industrial, IoT e desenvolvimento de software

---

## 🧪 Requisitos do Sistema

### Funcionais
- Coletar dados do controlador **OPTA Finder**
- Comunicar-se com o compressor via **Modbus**
- Armazenar informações no banco de dados
- Exibir informações em dashboards (**web e mobile**)
- Gerar e exibir falhas e alertas operacionais
- Permitir controle remoto do compressor via aplicativo mobile
- Permitir agendamento de horários de operação

### Não Funcionais
- Interface responsiva e amigável
- Baixa latência na atualização dos dados
- Alta disponibilidade do sistema
- Comunicação segura entre os componentes
- Padronização do ambiente de execução via Docker

---

## 🏗️ Arquitetura do Sistema

O sistema é composto pelas seguintes camadas:

### 🔌 Compressor & Controlador
- **Controlador OPTA Finder**
- Comunicação com o compressor via **Modbus**
- Leitura de sensores e escrita de comandos

### ⚙️ Gateway / Firmware (C++ – Arduino IDE)
- Desenvolvido em **C++**
- Funções:
  - Leitura dos dados do compressor via **Modbus**
  - Envio das leituras para a API via **HTTP (REST)**
  - Recebimento de comandos (liga/desliga/agendamentos) e execução no compressor

### 🔙 Backend – API
- **Spring Boot (Java)**
- Responsável por:
  - Receber dados do gateway
  - Persistir informações no banco de dados
  - Processar falhas, alertas e cargas horárias
  - Disponibilizar API REST para Web e Mobile

### 🌐 Frontend Web (Monitoramento)
- **React + TypeScript + Vite**
- Focado exclusivamente em monitoramento:
  - Cargas horárias para manutenção preventiva
  - Gráficos de histórico de sensores (últimos registros)
  - Listagem de falhas e alertas
  - Dashboards de acompanhamento do estado do compressor

### 📱 Aplicativo Mobile
- **Flutter**
- **Firebase Authentication**
- Funcionalidades:
  - Monitoramento em tempo real
  - Liga/desliga remoto do compressor
  - Agendamento de horários de operação
  - Acesso seguro via autenticação

---

## 🔐 Autenticação

- Implementada no **aplicativo mobile**
- Utiliza **Firebase Authentication**
- Garante acesso seguro às funcionalidades críticas de controle remoto

---

## 🚀 CI/CD e Deploy

O projeto utiliza **CI/CD com GitHub Actions**, executado em um **self-hosted runner** configurado no **servidor local do SENAI**.

### Workflows
- **API Spring Boot**
- **Frontend Web (React)**

### Funcionamento
- A cada **push na branch `main`**, os workflows são avaliados
- O deploy é **condicional por diretório**:
  - O workflow da API só executa se houver alterações na API
  - O workflow do Web só executa se houver alterações no frontend
- O deploy é realizado com **Docker Compose**, garantindo:
  - Padronização do ambiente
  - Isolamento dos serviços
  - Deploy automatizado e reprodutível

---

## 🌿 Padrão de Branches

O repositório segue um fluxo baseado em **Git Flow**:

- `main`: branch estável (produção)
- `develop`: branch de desenvolvimento e integração
- `feature/*`: branches para novas funcionalidades ou melhorias

---

## 🧰 Tecnologias Utilizadas

| Categoria | Tecnologias |
|--------|------------|
| **Gateway / Firmware** | C++ (Arduino IDE), Modbus |
| **Backend** | Java, Spring Boot |
| **Frontend Web** | React, TypeScript, Vite |
| **Mobile** | Flutter, Dart |
| **Autenticação** | Firebase Authentication |
| **Banco de Dados** | MySQL |
| **CI/CD** | GitHub Actions, Self-hosted Runner |
| **Deploy** | Docker, Docker Compose |
| **Versionamento** | Git, GitHub |

---

## 🚧 Status do Projeto

🟩 **Concluído**

O projeto teve seu escopo inicial finalizado e encontra-se funcional.  
Novas funcionalidades, melhorias ou manutenções poderão ser implementadas futuramente conforme necessidade.

---

## 👥 Equipe

| Integrante | Função |
|----------|------|
| **Murilo** | Backend / API / Web |
| **Nicolas** | Backend / API / Integração IoT / Líder |
| **Vinicius Gaban** | Web / Gestão de Projeto / Mobile (Flutter) |

---

## 📚 Contexto Acadêmico e Institucional

Este projeto foi desenvolvido no contexto do curso de **Análise e Desenvolvimento de Sistemas (ADS)**, como parte da unidade curricular **Projeto Integrador**.

A proposta do sistema foi apresentada pela própria **instituição SENAI**, a partir de uma **demanda real** relacionada ao monitoramento do compressor industrial utilizado em suas instalações. Dessa forma, o projeto alinhou os objetivos acadêmicos do curso com uma necessidade prática da instituição.

O desenvolvimento integrou conhecimentos de **automação industrial, IoT, backend, frontend web, mobile, banco de dados e DevOps**, consolidando na prática os conteúdos abordados ao longo do curso e promovendo uma experiência próxima à realidade do mercado.
