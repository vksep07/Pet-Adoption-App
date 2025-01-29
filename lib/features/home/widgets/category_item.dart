import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/spacing.dart';
import 'package:pet_adoption/features/home/model/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    this.selected = false,
    this.onTap,
  });

  final Category category;
  final bool selected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double boxSize = 90;
    double imageSize = 35;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.space4, AppSpacing.space20, AppSpacing.space4, 0),
        margin: const EdgeInsets.only(right: AppSpacing.space10),
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: selected ? AppColors.secondary : AppColors.cardColor,
          borderRadius: BorderRadius.circular(AppSpacing.space10),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withOpacity(0.1),
              spreadRadius: .5,
              blurRadius: .5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              category.icon,
              width: imageSize,
              height: imageSize,
              color: selected ? Colors.white : Colors.black,
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppSpacing.space12,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : AppColors.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
