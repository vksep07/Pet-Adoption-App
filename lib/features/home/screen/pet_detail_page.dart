import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/app_images.dart';
import 'package:pet_adoption/common/constants/app_text_style.dart';
import 'package:pet_adoption/common/constants/spacing.dart';
import 'package:pet_adoption/common/widgets/common_text.dart';
import 'package:pet_adoption/features/home/home_service.dart';
import 'package:pet_adoption/features/home/model/pet_model.dart';
import 'package:pet_adoption/features/home/widgets/pet_detail_top_image_section.dart';
import 'package:pet_adoption/features/home/widgets/pet_info_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_adoption/features/home/widgets/stamp_widget.dart';

class PetDetailScreen extends StatefulWidget {
  final Pet pet;

  const PetDetailScreen({super.key, required this.pet});

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
  final _homeService = HomeService.getInstance();
  late Pet pet;

  @override
  void initState() {
    pet = widget.pet;
    super.initState();
    _homeService.addToHistoryPage(pet.index);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.share,
              color: Colors.white,
            ),
            onPressed: () {
              // Do Code here
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  PetDetailTopImageSection(pet: pet),
                  PetInfoSection(pet: pet),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  true, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
              // createParticlePath: drawStar, // define a custom shape/path.
            ),
          ),
        ],
      ),
      bottomNavigationBar: (!pet.isAdopted)
          ? DetailScreenBottom(
              pet: pet,
              onTap: () {
                _confettiController.play();
                _homeService.addToAdoptionList(pet.index);
                Future.delayed(const Duration(seconds: 3), () {
                  _confettiController.stop();
                });
                if (mounted) {
                  setState(() {
                    pet = pet.copyWith(isAdopted: true);
                  });
                }
              })
          : const SizedBox(),
    );
  }
}

class DetailScreenBottom extends StatelessWidget {
  final Pet pet;
  final Function()? onTap;
  const DetailScreenBottom({
    super.key,
    required this.pet,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final color = (pet.isAdopted)
        ? AppColors.secondary.withOpacity(0.5)
        : AppColors.secondary;

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.space10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            color: color,
            spreadRadius: 0,
            blurRadius: AppSpacing.space10,
          )
        ],
        color: color,
      ),
      child: InkWell(
        onTap: () {
          if (!pet.isAdopted) onTap?.call();
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: (pet.isAdopted)
                    ? appLocalizations.adopted
                    : appLocalizations.adoptMe,
                color: Colors.white,
                style: AppTextStyle.titleMedium(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final Color color;
  final String valueText, keyText;
  const DetailItem({
    super.key,
    required this.color,
    required this.valueText,
    required this.keyText,
  });

  @override
  Widget build(BuildContext context) {
    double containerHeight = 80;
    double containerWidth = MediaQuery.of(context).size.width / 3 - 25;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          Container(
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              color: color.withOpacity(0.6),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: -AppSpacing.space10,
                  right: -5,
                  child: Transform.rotate(
                    angle: AppSpacing.space12,
                    child: SvgPicture.asset(
                      AppImages.petImage,
                      color: color,
                      height: AppSpacing.space60,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: containerHeight,
            width: containerWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  text: valueText,
                  style: AppTextStyle.titleMedium(),
                ),
                CommonText(
                  text: keyText,
                  color: Colors.black54,
                  style: AppTextStyle.bodyMedium(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PetProfileInfo extends StatelessWidget {
  const PetProfileInfo({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: pet.name.toString(),
              color: AppColors.textColor,
              style: AppTextStyle.titleMedium(),
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.blue,
                  size: AppSpacing.space16,
                ),
                CommonText(
                  text: pet.location,
                  color: AppColors.textColor,
                  style: AppTextStyle.bodySmall(),
                ),
              ],
            )
          ],
        ),
        const Spacer(),
        if (pet.isAdopted)
          StampWidget(
            text: appLocalizations.adopted,
          ),
      ],
    );
  }
}
