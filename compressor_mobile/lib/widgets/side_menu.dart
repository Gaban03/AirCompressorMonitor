part of '_widgets_lib.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16,
      shadowColor: Colors.black87,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2B2B2B),
              Color(0xFF1E1E1E),
              Color(0xFF151515),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SideMenuHeader(),
              const SizedBox(height: 25),
              SideMenuItem(
                icon: FontAwesomeIcons.house,
                title: "Início",
                onTap: () => _navigateTo(context, const HomeView()),
              ),
              SideMenuItem(
                icon: FontAwesomeIcons.gear,
                title: "Configurações",
                onTap: () => _navigateTo(context, const ConfigPage()),
              ),
              SideMenuItem(
                icon: FontAwesomeIcons.circleInfo,
                title: "Sobre",
                onTap: () => _navigateTo(context, const About()),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                child: Divider(
                  color: Colors.white.withOpacity(0.15),
                  thickness: 1,
                ),
              ),
              SideMenuItem(
                icon: FontAwesomeIcons.arrowRightFromBracket,
                title: "Sair",
                color: Colors.redAccent,
                onTap: () async {
                  final confirmed = await DialogAction.show(
                    context: context,
                    title: "Confirmar saída",
                    content: "Deseja realmente sair da sua conta?",
                    icon: Icons.logout,
                    iconColor: Colors.redAccent,
                  );
                  if (confirmed) await AuthService().signout(context: context);
                },
              ),
              const SideMenuFooter(),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
