import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final List<TextInputFormatter> inputFormatters;
  final String? hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool enable;
  final Function()? onTap;

  const CustomTextfield(
      {super.key,
      this.inputFormatters = const [],
      this.hintText,
      this.onChanged,
      this.obscureText = false,
      this.initialValue,
      this.keyboardType,
      this.validator,
      this.suffixIcon,
      this.enable = true,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      initialValue: initialValue,
      enabled: enable,
      keyboardType: keyboardType,
      //  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      obscureText: obscureText!,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        filled: false,

        //  fillColor: Color(0xffE5E5E5),

        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),

      onChanged: onChanged,
      validator: validator,
    );
  }
}
