part of '_widgets_lib.dart';

enum SnackType { success, error, info }

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackType type = SnackType.info,
  }) {
    final Color bgColor;
    final IconData icon;

    switch (type) {
      case SnackType.success:
        bgColor = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case SnackType.error:
        bgColor = Colors.redAccent;
        icon = Icons.error_outline;
        break;
      case SnackType.info:
      default:
        bgColor = Colors.blueAccent;
        icon = Icons.info_outline;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        duration: const Duration(seconds: 2),
        elevation: 6,
      ),
    );
  }
}
