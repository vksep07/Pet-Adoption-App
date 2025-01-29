import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/app_text_style.dart';
import 'package:pet_adoption/common/constants/data.dart';
import 'package:pet_adoption/common/constants/extensions.dart';
import 'package:pet_adoption/common/constants/spacing.dart';
import 'package:pet_adoption/common/widgets/common_text.dart';
import 'package:pet_adoption/features/home/widgets/category_item.dart';
import 'package:pet_adoption/features/home/home_service.dart';
import 'package:pet_adoption/features/home/model/category_model.dart';
import 'package:pet_adoption/features/home/model/pet_model.dart';
import 'package:pet_adoption/features/home/widgets/pet_profile_item.dart';
import 'package:pet_adoption/features/search/search_bar_screen.dart';
import 'package:pet_adoption/navigation/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeService = HomeService.getInstance();
  int _selectedCategory = 0;
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeService.getHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: SafeArea(
        top: true,
        bottom: false,
        child: ValueListenableBuilder<bool>(
          valueListenable: _homeService.isLoading,
          builder: (context, value, child) {
            if (value && _homeService.categories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.space10),
              child: Column(
                children: [
                  _buildAppBar(),
                  AppSpacing.space20.heightBox,
                  _buildSearchBar(),
                  AppSpacing.space20.heightBox,
                  _buildCategories(_homeService.categories),
                  AppSpacing.space20.heightBox,
                  ValueListenableBuilder<List<Pet>>(
                    valueListenable: _homeService.petsList,
                    builder: (context, pets, child) {
                      final petTypeFilter = (_homeService.categories.isNotEmpty)
                          ? _homeService.categories[_selectedCategory].petType
                          : PetType.all;
                      return pets.isEmpty
                          ? CommonText(
                              text: _appLocalizations.noPetsForAdoption,
                              style: AppTextStyle.titleMedium(),
                            )
                          : _buildPets(pets, petTypeFilter);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.place_outlined,
              color: AppColors.labelColor,
              size: AppSpacing.space20,
            ),
            AppSpacing.space4.widthBox,
            CommonText(
              text: _appLocalizations.location,
              style: AppTextStyle.bodyMedium(),
            ),
          ],
        ),
        AppSpacing.space3.heightBox,
        CommonText(
          text: "Phnom Penh, Cambodia",
          style: AppTextStyle.bodyMedium(),
        ),
      ],
    );
  }

  _buildPets(List<Pet> pets, PetType petTypeFilter) {
    return Flexible(
      child: ListView.builder(
   
        shrinkWrap: true,
        itemCount: pets.length,
        itemBuilder: (context, index) {
          if (pets[index].petType != petTypeFilter &&
              petTypeFilter != PetType.all) {
            return const SizedBox();
          }
          return PetProfileItem(
            key: Key(pets[index].id),
            pet: pets[index],
            onTap: () {
              final pet = pets[index].copyWith(index: index);
              _homeService.addToHistoryPage(index);
              Navigator.of(context)
                  .pushNamed(AppRoutes.petDetail, arguments: pet);
            },
            onFavoriteTap: (p0) {
              _homeService.addToFavorite(index);
            },
          );
        },
      ),
    );
  }

  _buildCategories(List<Category> categories) {
    List<Widget> lists = List.generate(
      categories.length,
      (index) => CategoryItem(
        category: categories[index],
        selected: index == _selectedCategory,
        onTap: () {
          if (mounted) {
            setState(() {
              _selectedCategory = index;
            });
          }
        },
      ),
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: lists),
    );
  }

  Widget _buildSearchBar() {
    double height = 50;
    return OpenContainer<bool>(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return const SearchBarScreen();
      },
      tappable: false,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.space6),
            child: Container(
              height: height,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.all(AppSpacing.space8),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    CommonText(text: " Search for pets"),
                    Spacer(),
                    Icon(
                      Icons.filter_list,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
