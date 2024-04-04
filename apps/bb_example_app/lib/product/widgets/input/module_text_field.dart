// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:values/values.dart';

class ModuleTextField extends StatelessWidget {
  const ModuleTextField({
    required this.controller,
    super.key,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.labelText,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.autoFocus,
    this.hintText,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? labelText;
  final bool obscureText;
  final bool? autoFocus;
  final void Function(String?)? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: context.titleMedium.copyWith(
          color: context.onInverseSurface,
        ),
      ),
      controller: controller,
      autofocus: autoFocus ?? false,
      obscureText: obscureText,
      textInputAction: textInputAction ?? TextInputAction.next,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
