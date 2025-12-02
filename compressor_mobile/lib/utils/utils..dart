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
}
