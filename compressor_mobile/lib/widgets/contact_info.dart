part of '_widgets_lib.dart';

class ContactInfo extends StatelessWidget {
  final Developer developer;
  const ContactInfo({super.key, required this.developer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContactRow(
            icon: Icons.email_rounded,
            text: developer.email,
          ),
          const SizedBox(height: 12),
          ContactRow(
            icon: Icons.phone_rounded,
            text: developer.telefone,
          ),
        ],
      ),
    );
  }
}
