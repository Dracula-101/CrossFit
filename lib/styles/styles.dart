import 'package:flutter/material.dart';

export 'colors.dart';
export 'font_style.dart';
export 'themes.dart';

InputDecoration inputDecoration(
    String hintText, IconData? prefixIcon, IconData? suffixIcon) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    hintText: hintText,
    label: Text(hintText),
    labelStyle: const TextStyle(color: Colors.white),
    hintStyle: const TextStyle(color: Colors.grey),
    focusedBorder: outlineBorder(),
    enabledBorder: outlineBorder(),
    errorBorder: errorBorder(),
    focusedErrorBorder: errorBorder(),
    prefixIcon: prefixIcon != null
        ? Icon(
            prefixIcon,
            color: Colors.white,
          )
        : null,
    suffixIcon: suffixIcon != null
        ? Icon(
            suffixIcon,
            color: Colors.white,
          )
        : null,
    errorStyle: const TextStyle(color: Colors.white),
    filled: true,
    fillColor: Colors.white.withOpacity(0.1),
    border: outlineBorder(),
    enabled: true,
  );
}

OutlineInputBorder outlineBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1,
    ),
  );
}

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Colors.red,
      width: 1,
    ),
  );
}

TextFormField inputTextForm(
    {String? hintText,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool obscureText = false,
    required String? Function(String?) validator,
    Function(String)? onChanged}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    validator: validator,
    onChanged: onChanged,
    decoration: inputDecoration(hintText ?? '', null, null),
  );
}
