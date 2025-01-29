import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/extensions.dart';
import 'package:pet_adoption/common/constants/spacing.dart';
import 'package:pet_adoption/features/home/home_service.dart';
import 'package:pet_adoption/features/home/model/pet_model.dart';
import 'package:pet_adoption/features/home/widgets/pet_profile_item.dart';
import 'package:pet_adoption/navigation/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({super.key});

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  final _homeService = HomeService.getInstance();
  final ValueNotifier<List<Pet>> _petsList = ValueNotifier<List<Pet>>([]);
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
      const Duration(milliseconds: 200),
      () {
        if (query.isEmpty) {
          _petsList.value = [];
          return;
        }
        _petsList.value = _homeService.filterPets(query: query);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space10),
          child: Column(
            children: [
              _buildSearchBarWithBackButton(),
              AppSpacing.space20.heightBox,
              Expanded(
                child: ValueListenableBuilder<List<Pet>>(
                  valueListenable: _petsList,
                  builder: (context, value, child) {
                    return _buildPets(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBarWithBackButton() {
    return Container(
      height: AppSpacing.space50,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(AppSpacing.space10)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          AppSpacing.space10.widthBox,
          Expanded(
            child: TextField(
              autofocus: true,
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration:  InputDecoration(
                hintText: _appLocalizations.searchForPets,
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(
            Icons.filter_list,
            color: Colors.grey,
          ),
          AppSpacing.space10.widthBox,
        ],
      ),
    );
  }

  Widget _buildPets(List<Pet> pets) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: pets.length,
        itemBuilder: (context, index) {
          if (pets.isEmpty) {
            return const SizedBox();
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
  }
}
