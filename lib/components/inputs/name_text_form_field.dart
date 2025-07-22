import 'package:flutter/material.dart';

class NameTextFormField extends StatefulWidget {
  const NameTextFormField({
    super.key,
    this.validator,
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.isPassword = false,
  });
  final String? Function(String?)? validator;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;

  @override
  State<NameTextFormField> createState() => _NameTextFormFieldState();
}

class _NameTextFormFieldState extends State<NameTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? obscureText : false,

      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() {
                  obscureText = !obscureText;
                }),
              )
            : null,
        suffixIconConstraints: BoxConstraints(maxWidth: 45),
      ),
    );
  }
}
