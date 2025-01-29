import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/app_images.dart';
import 'package:pet_adoption/common/constants/app_text_style.dart';
import 'package:pet_adoption/common/constants/extensions.dart';
import 'package:pet_adoption/common/constants/spacing.dart';
import 'package:pet_adoption/common/widgets/common_text.dart';
import 'package:pet_adoption/features/home/model/pet_model.dart';
import 'package:pet_adoption/features/home/widgets/stamp_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetProfileItem extends StatelessWidget {
  final Function onTap;
  final Pet pet;
  final Function(Pet) onFavoriteTap;

  const PetProfileItem({
    super.key,
    required this.onTap,
    required this.pet,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    double width = 100;
    double height = 110;

    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          vertical: AppSpacing.space4,
          horizontal: 0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.space6,
          horizontal: AppSpacing.space6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.space10),
        ),
        child: AnimatedOpacity(
          opacity: pet.isAdopted ? 0.3 : 1.0,
          duration: const Duration(seconds: 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: pet.location,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpacing.space10),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(
                        pet.image,
                        errorBuilder: (context, error, stackTrace) {
                          return _getBackground();
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return _getBackground();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.space12.widthBox,
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppSpacing.space8.heightBox,
                  CommonText(
                    text: pet.name,
                    color: Colors.black,
                    style: AppTextStyle.titleMedium(),
                  ),
                  AppSpacing.space2.heightBox,
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.star,
                        color: AppColors.green,
                        size: AppSpacing.space18,
                      ),
                      CommonText(
                        text: "${pet.rate}",
                        style: AppTextStyle.bodyMedium(),
                      ),
                    ],
                  ),
                  AppSpacing.space2.heightBox,
                  CommonText(
                    text: '•${pet.sex}  •${pet.age}  •${pet.color}',
                    style: AppTextStyle.bodyMedium(),
                    color: AppColors.darker,
                  ),
                  AppSpacing.space2.heightBox,
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey),
                      CommonText(text: pet.location),
                    ],
                  ),
                  AppSpacing.space8.heightBox,
                ],
              ),
              const Spacer(),
              (pet.isAdopted)
                  ? StampWidget(text: appLocalizations.adopted)
                  : IconButton(
                      icon: Icon(
                        pet.isFavorite
                            ? Icons.favorite // Filled heart for favorite
                            : Icons
                                .favorite_outline, // Outline heart for not favorite
                        color: pet.isFavorite
                            ? AppColors.red
                            : Colors.grey, // Red for favorite, grey for not
                      ),
                      onPressed: () {
                        onFavoriteTap.call(pet);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBackground() {
    double size = 100;
    double height = 60;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.green.withOpacity(0.6),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: -10,
            right: -5,
            child: Transform.rotate(
              angle: 12,
              child: SvgPicture.asset(
                AppImages.petImage,
                height: height,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
