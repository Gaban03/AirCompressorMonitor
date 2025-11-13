part of '_widgets_lib.dart';

class ProfileInfoRow extends StatelessWidget {
  final int posts;
  final int followers;
  final int following;

  const ProfileInfoRow({
    super.key,
    required this.posts,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      ProfileInfoItem("Posts", posts),
      ProfileInfoItem("Seguidores", followers),
      ProfileInfoItem("Seguindo", following),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.redAccent.withOpacity(0.25), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          final index = items.indexOf(item);
          return Expanded(
            child: Row(
              children: [
                if (index != 0)
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.redAccent.withOpacity(0.2),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                Expanded(child: _singleItem(context, item)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.value.toString(),
            style: GoogleFonts.orbitron(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.title.toUpperCase(),
            style: GoogleFonts.openSans(
              fontSize: 12,
              color: Colors.white60,
              letterSpacing: 1,
            ),
          ),
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}
