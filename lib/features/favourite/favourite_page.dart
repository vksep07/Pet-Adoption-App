import 'package:flutter/material.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/app_text_style.dart';
import 'package:pet_adoption/common/widgets/common_text.dart';
import 'package:pet_adoption/features/home/home_service.dart';
import 'package:pet_adoption/features/home/model/pet_model.dart';
import 'package:pet_adoption/features/home/widgets/pet_profile_item.dart';
import 'package:pet_adoption/navigation/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePagePageState();
}

class _FavouritePagePageState extends State<FavouritePage> {
  final _homeService = HomeService.getInstance();
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: CommonText(
          text: _appLocalizations.favourite,
          style: AppTextStyle.titleLarge(),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _buildPets(),
    );
  }

  _buildPets() {
    return ValueListenableBuilder<List<Pet>>(
      valueListenable: _homeService.petsList,
      builder: (context, pets, child) {
        bool isFavorite = pets.any((element) => element.isFavorite);
        if (!isFavorite) {
          return Center(
            child: CommonText(
              text: _appLocalizations.noFavouritePets,
              style: AppTextStyle.titleMedium(),
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: pets.length,
            itemBuilder: (context, index) {
              bool isFavorite = pets[index].isFavorite;
              if (!isFavorite) {
                return const SizedBox.shrink();
              }
              return PetProfileItem(
                key: Key(pets[index].id),
                pet: pets[index],
                onTap: () {
                  _homeService.addToHistoryPage(index);
                  Navigator.of(context)
                      .pushNamed(AppRoutes.petDetail, arguments: pets[index]);
                },
                onFavoriteTap: (p0) {
                  _homeService.addToFavorite(index);
                },
              );
            },
          ),
        );
      },
    );
  }
}
