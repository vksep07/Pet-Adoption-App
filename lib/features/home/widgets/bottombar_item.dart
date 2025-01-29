import 'package:flutter/material.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/spacing.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem(
    this.icon, {super.key, 
    this.onTap,
    this.color = Colors.black,
    this.activeColor = AppColors.primary,
    this.isActive = false,
    this.isNotified = false,
  });

  final Widget icon;
  final Color color;
  final Color activeColor;
  final bool isNotified;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(AppSpacing.space6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: isActive
                    ? AppColors.primary.withOpacity(.1)
                    : Colors.transparent,
              ),
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}