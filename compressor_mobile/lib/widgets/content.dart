part of "_widgets_lib.dart";

class Content extends StatelessWidget {
  final String title;
  final Widget body;

  const Content({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: SideMenu(parentContext: context),
      appBar: CustomAppBar(title: title),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E1E1E),
              Color(0xFF2B2B2B),
              Color(0xFF3A3A3A),
            ],
          ),
        ),
        child: body,
      ),
    );
  }
}
