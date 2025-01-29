import 'package:flutter/material.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/spacing.dart';

class StampWidget extends StatelessWidget {
  final String text;

  const StampWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppSpacing.space50, // Width of the stamp (circle)
        height: AppSpacing.space50, // Height of the stamp (circle)
        decoration: BoxDecoration(
          color: Colors.transparent, // Background color of the stamp
          shape: BoxShape.circle, // Circular shape
          border: Border.all(
            color: AppColors.red, // Border color of the stamp
            width: 1, // Border width
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.red, // Text color
              fontWeight: FontWeight.bold,
              fontSize:AppSpacing.space8,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
