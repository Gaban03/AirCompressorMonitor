part of '_views_lib.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
    return false;
  }

  final List<Developer> developers = [
    Developer(
      nome: 'Murilo Camargo',
      cargo: 'Desenvolvedor Back-End',
      email: 'muriloherrick@gmail.com',
      telefone: 'Celular: (16) 99754-4500',
      fotoUrl: 'assets/images/img_murilo.jpg',
    ),
    Developer(
      nome: 'Nicolas Ribeiro',
      cargo: 'Desenvolvedor de Embarcados e Infraestrutura',
      email: 'nicolas.ribeiro@sp.senai.br',
      telefone: 'Celular: (16) 99120-4354',
      fotoUrl: 'assets/images/img_nicolas.jpg',
    ),
    Developer(
      nome: 'Pedro Martins',
      cargo: 'Desenvolvedor Back-End',
      email: 'pedroenriquellopes2011@gmail.com',
      telefone: 'Celular: (16) 98898-6094',
    ),
    Developer(
      nome: 'Vinicius Ramos',
      cargo: 'Desenvolvedor de Embarcados',
      email: 'viniciusaugusto6996@gmail.com',
      telefone: 'Celular: (16) 99251-5599',
    ),
    Developer(
      nome: 'Vinicius Gaban',
      cargo: 'Desenvolvedor Mobile',
      email: 'gabanvinicius724@gmail.com',
      telefone: 'Celular: (16) 99100-0062',
      fotoUrl: 'assets/images/img_gaban.jpg',
      githubUrl: 'https://github.com/Gaban03',
      linkedinUrl: 'https://www.linkedin.com/in/vinicius-gaban/',
    ),
  ];

  void _openDeveloperDetail(Developer dev) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DeveloperProfilePage(developer: dev),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Content(
        title: "SENAI",
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Seção do projeto ---
              Text(
                'Projeto Monitoramento Compressor',
                style: GoogleFonts.orbitron(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 60,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'O Monitoramento de Compressor de Ar é uma plataforma desenvolvida como projeto integrador na Faculdade de Tecnologia e Escola SENAI Antonio Adolpho Lobbe.'
                ' O objetivo é implementar uma solução para acompanhar, em tempo real, o funcionamento e as condições operacionais de um compressor industrial, contribuindo para manutenção preditiva e evitando paradas inesperadas.',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 40),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    'Desenvolvedores',
                    style: GoogleFonts.orbitron(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // --- Lista dos devs ---
              ...developers.map((dev) => _buildDeveloperCard(dev)),

              const SizedBox(height: 40),
              Center(
                child: Text(
                  "© 2025 - SENAI São Carlos",
                  style: GoogleFonts.openSans(
                    color: Colors.white38,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperCard(Developer dev) {
    return InkWell(
      onTap: () => _openDeveloperDetail(dev),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: Colors.redAccent.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.redAccent.withOpacity(0.9),
                child: ClipOval(
                  child: dev.fotoUrl != null
                      ? Image.asset(dev.fotoUrl!,
                          fit: BoxFit.cover, width: 64, height: 64)
                      : Center(
                          child: Text(
                            dev.nome.substring(0, 1),
                            style: GoogleFonts.orbitron(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dev.nome,
                      style: GoogleFonts.orbitron(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dev.cargo,
                      style: GoogleFonts.openSans(
                        color: Colors.white70,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.email,
                            size: 15, color: Colors.white54),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            dev.email,
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              color: Colors.white60,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.phone,
                            size: 15, color: Colors.white54),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            dev.telefone,
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              color: Colors.white60,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.redAccent, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
