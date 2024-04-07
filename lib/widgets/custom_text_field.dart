import "package:flutter/material.dart";

import "../consts/app_colors.dart";

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  Icon? icon;
  Color? icon_color;

  CustomTextFormField({
    required this.controller,
    required this.hint,
    this.icon,
    this.icon_color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.amber,
      decoration: InputDecoration(
          label: Text(hint),
          prefixIcon: icon,
          prefixIconColor: icon_color,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.black,
              ))),
    );
  }
}
