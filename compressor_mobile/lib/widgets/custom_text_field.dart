part of '_widgets_lib.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final bool obscureText;
  final String? Function(String?)? validator;
  final VoidCallback? onToggleVisibility;
  final Color backgroundColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final double borderRadius;
  final double elevation;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.obscureText = false,
    this.validator,
    this.onToggleVisibility,
    this.backgroundColor = const Color(0xFF2B2B2B),
    this.borderColor = const Color(0xFF3A3A3A),
    this.focusedBorderColor = Colors.redAccent,
    this.errorBorderColor = Colors.redAccent,
    this.borderRadius = 14.0,
    this.elevation = 3.0,
    this.labelStyle,
    this.hintStyle,
    this.inputTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      shadowColor: Colors.black45,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2C2C2C),
              Color(0xFF262626),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isPassword ? obscureText : false,
          style: inputTextStyle ??
              const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            labelText: label,
            labelStyle: labelStyle ??
                const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
            hintText: hint,
            hintStyle: hintStyle ??
                const TextStyle(
                  fontSize: 14,
                  color: Colors.white38,
                ),
            prefixIcon:
                Icon(prefixIcon, color: Colors.redAccent.withOpacity(0.9)),
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1.2),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor, width: 2),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: errorBorderColor, width: 1.5),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: errorBorderColor, width: 2),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
