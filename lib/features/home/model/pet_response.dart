import 'package:pet_adoption/features/home/model/category_model.dart';
import 'package:pet_adoption/features/home/model/pet_model.dart';

class PetResponse {
  final List<Category> categories;
  final List<Pet> pets;

  PetResponse({
    required this.categories,
    required this.pets,
  });

  factory PetResponse.fromJson(Map<String, dynamic> json) {
    return PetResponse(
      categories: List<Category>.from(
        json['categories'].map((category) => Category.fromJson(category)),
      ),
      pets: List<Pet>.from(
        json['pets'].map((pet) => Pet.fromJson(pet)),
      ),
    );
  }
}
