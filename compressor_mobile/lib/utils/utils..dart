part of '_utils_lib.dart';

extension R on BuildContext {
  Size get screen => MediaQuery.of(this).size;
  double get sw => screen.width;
  double get sh => screen.height;
  double get textScale => MediaQuery.of(this).textScaleFactor;

  double wp(double percent) => sw * (percent / 100);

  double hp(double percent) => sh * (percent / 100);

  double rf(double fontSize, {double baseWidth = 390}) {
    final widthScale = sw / baseWidth;
    return fontSize * widthScale * textScale;
  }

  String formatTimeOfDay(TimeOfDay t) {
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }

  TimeOfDay parseTimeString(String hhmm) {
    final parts = hhmm.split(':');
    final h = int.tryParse(parts[0]) ?? 0;
    final m = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return TimeOfDay(hour: h, minute: m);
  }

  /// Converte lista de dias EN -> PT (para exibição)
  List<String> diasEnToPtList(List<String> enList) {
    return enList.map((e) => diasENtoPT[e] ?? e).toList();
  }

  /// Converte lista de dias PT -> EN (para enviar à API)
  List<String> diasPtToEnList(List<String> ptList) {
    return ptList.map((p) => diasPTtoEN[p] ?? p).toList();
  }

  /// TimePicker em padrão BR (24h) + Tema escuro estilizado
  Future<TimeOfDay?> showTimePickerBR({
    required BuildContext context,
    required TimeOfDay initial,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.redAccent,
                onPrimary: Colors.white,
                surface: Color(0xFF1A1A1A),
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: const Color(0xFF121212),
              timePickerTheme: const TimePickerThemeData(
                backgroundColor: Color(0xFF1A1A1A),
                hourMinuteTextColor: Colors.white, // ⬅ aqui mudou
                hourMinuteShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                dialHandColor: Colors.redAccent,
                dialBackgroundColor: Color(0xFF2A2A2A),
                helpTextStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );
  }
}
