import 'package:dsit_app/consts/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onPress;
  final String button_text;
  const CustomButtonWidget({
    super.key,
    required this.onPress,
    required this.button_text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(AppColors.button_color)
      ),
      child: Text(
        button_text,
        style: TextStyle(color: Colors.black.withOpacity(0.8)),
      ),
    );
  }
}
