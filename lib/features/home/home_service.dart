import 'package:flutter/material.dart';
import 'package:pet_adoption/common/network/http_service.dart';
import 'package:pet_adoption/features/home/model/category_model.dart';
import 'package:pet_adoption/features/home/model/pet_model.dart';
import 'package:pet_adoption/features/home/model/pet_response.dart';

class HomeService {
  static HomeService? _instance;
  HomeService._();
  static HomeService getInstance() {
    _instance ??= HomeService._();
    return _instance!;
  }

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Pet>> petsList = ValueNotifier<List<Pet>>([]);

  final _httpService = HttpService();
  final String endpoint =
      'https://run.mocky.io/v3/565d7de7-abe0-4931-bedc-92d9ccd8117e';

  final List<Category> _categories = [];
  final List<Pet> _pets = [];

  List<Category> get categories => _categories;
  List<Pet> get pets => _pets;

  Future<void> getHomeData() async {
    try {
      isLoading.value = true;
      Map<String, dynamic> jsonData = await _httpService.get(endpoint);
      PetResponse petResponse = PetResponse.fromJson(jsonData);
      _categories.addAll(petResponse.categories);
      _pets.addAll(petResponse.pets);
      petsList.value = _pets.toList();
    } finally {
      isLoading.value = false;
    }
  }

  List<Pet> filterPets({
    String? query,
  }) {
    List<Pet> filteredPets = [];
    if (query == null || query.isEmpty) {
      filteredPets = List.from(_pets); // If no query, show all pets
    } else {
      filteredPets = _pets.where((pet) {
        bool matches = false;

        // Normalize the query to lowercase for case-insensitive search
        String lowerQuery = query.toLowerCase();

        // Check if the query matches any of the pet's fields
        matches |= pet.name.toLowerCase().contains(lowerQuery); // Match name
        matches |= pet.description
            .toLowerCase()
            .contains(lowerQuery); // Match description
        matches |= pet.color.toLowerCase().contains(lowerQuery); // Match color
        matches |= pet.age.toLowerCase().contains(lowerQuery); // Match age
        matches |= pet.sex.toLowerCase().contains(lowerQuery); // Match sex
        matches |= pet.price.toLowerCase().contains(lowerQuery); // Match price
        matches |=
            pet.location.toLowerCase().contains(lowerQuery); // Match location

        // Optionally, check for petType, if query matches enum names
        matches |= pet.petType.toString().toLowerCase().contains(lowerQuery);

        return matches;
      }).toList();
    }

    return filteredPets; // Update the pets list to reflect the filtered list
  }

  void addToFavorite(int index) {
    if (pets.isEmpty) return;
    _pets[index] = _pets[index].copyWith(isFavorite: !_pets[index].isFavorite);
    petsList.value = [..._pets];
  }

  void addToHistoryPage(int index) {
    if (pets.isEmpty) return;
    bool isVisited = pets[index].isVisited;
    if (isVisited) return;
    _pets[index] = _pets[index].copyWith(isVisited: true);
    petsList.value = [..._pets];
  }

  void addToAdoptionList(int index) {
    if (pets.isEmpty) return;
    bool isAdopted = pets[index].isAdopted;
    if (isAdopted) return;
    _pets[index] = _pets[index].copyWith(isAdopted: true);
    petsList.value = [..._pets];
  }
}
