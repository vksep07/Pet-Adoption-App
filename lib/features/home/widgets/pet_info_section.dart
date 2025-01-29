
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/app_images.dart';
import 'package:pet_adoption/common/constants/app_text_style.dart';
import 'package:pet_adoption/common/constants/extensions.dart';
import 'package:pet_adoption/common/constants/spacing.dart';
import 'package:pet_adoption/common/widgets/common_text.dart';
import 'package:pet_adoption/features/home/model/pet_model.dart';
import 'package:pet_adoption/features/home/screen/pet_detail_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetInfoSection extends StatelessWidget {
  const PetInfoSection({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    double radius = 22;
    return ColoredBox(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space20,
          vertical: AppSpacing.space30,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              AppSpacing.space20,
            ),
            topRight: Radius.circular(
              AppSpacing.space20,
            ),
          ),
        ),
        child: Column(
          children: [
            PetProfileInfo(pet: pet),
            AppSpacing.space20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailItem(
                  color: AppColors.green,
                  valueText: pet.sex,
                  keyText: appLocalizations.sex,
                ),
                DetailItem(
                  color: AppColors.orange,
                  valueText: pet.age,
                  keyText: appLocalizations.age,
                ),
                DetailItem(
                  color: AppColors.blue,
                  valueText: pet.weight,
                  keyText: appLocalizations.weight,
                )
              ],
            ),
            AppSpacing.space20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CircleAvatar(
                  radius: radius,
                  backgroundColor: AppColors.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.space10),
                    child: SvgPicture.asset(
                      AppImages.petImage,
                      color: Colors.white,
                    ),
                  ),
                ),
                AppSpacing.space10.widthBox,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CommonText(
                            text: pet.ownerName,
                            color: AppColors.primary,
                            style: AppTextStyle.titleMedium(),
                          ),
                          CommonText(
                            text: pet.date,
                            color: Colors.grey,
                            style: AppTextStyle.titleSmall(),
                          ),
                        ],
                      ),
                      CommonText(
                        text: appLocalizations.owner,
                        color: Colors.grey,
                        style: AppTextStyle.titleSmall(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.space20.heightBox,
            CommonText(
              text: pet.description,
              style: AppTextStyle.bodyMedium(),
            ),
          ],
        ),
      ),
    );
  }
}
