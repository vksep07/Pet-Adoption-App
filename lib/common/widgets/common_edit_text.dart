import 'package:flutter/material.dart';

class CommonEditText extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  const CommonEditText({super.key, required this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}