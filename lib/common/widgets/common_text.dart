import 'package:flutter/material.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';

class CommonText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;

  const CommonText({
    super.key,
    required this.text,
    this.style,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style?.copyWith(
            color: color ?? AppColors.textColor,
          ) ??
          Theme.of(context).textTheme.bodyMedium,
    );
  }
}
