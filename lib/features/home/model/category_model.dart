import 'package:pet_adoption/features/home/model/pet_model.dart';

class Category {
  final String name;
  final String icon;
  final PetType petType;

  Category({
    required this.name,
    required this.icon,
    required this.petType,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      petType: getPetTypeFromString((json['type'] ?? '').toString().toLowerCase()),
      name: json['name'],
      icon: json['icon'],
    );
  }
}
