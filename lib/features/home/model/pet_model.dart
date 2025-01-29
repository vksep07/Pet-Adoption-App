class Pet {
  final String image;
  final String name;
  final String location;
  final bool isFavorite;
  final String description;
  final double rate;
  final String id;
  final String price;
  final String ownerName;
  final String ownerPhoto;
  final String sex;
  final String age;
  final String color;
  final List<String> album;
  final PetType petType;
  final bool isVisited;
  final int index;
  final bool isAdopted;
  final String weight;
  final String date;

  Pet({
    required this.petType,
    required this.image,
    required this.name,
    required this.location,
    required this.isFavorite,
    required this.description,
    required this.rate,
    required this.id,
    required this.price,
    required this.ownerName,
    required this.ownerPhoto,
    required this.sex,
    required this.age,
    required this.color,
    required this.album,
    required this.weight,
    required this.date,
    this.isVisited = false,
    this.index = 0,
    this.isAdopted = false,
  });

  // Factory constructor for creating a Pet from JSON data
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      petType: getPetTypeFromString(json['petType']),
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
      isVisited: json['isVisited'] ?? false,
      isAdopted: json['isAdopted'] ?? false,
      description: json['description'] ?? '',
      rate: (json['rate'] ?? '4.5').toDouble(),
      id: json['id'] ?? '',
      price: json['price'] ?? '',
      ownerName: json['owner_name'] ?? '',
      ownerPhoto: json['owner_photo'] ?? '',
      sex: json['sex'] ?? '',
      age: json['age'] ?? '',
      color: json['color'] ?? '',
      index: json['index'] ?? 0,
      weight: json['weight'] ?? '',
      date: json['date'] ?? '',
      album: List<String>.from(json['album'] ?? []),
    );
  }

  // Method to convert the object into a map
  Map<String, dynamic> toJson() {
    return {
      'petType': petType.toString().split('.').last,
      'image': image,
      'name': name,
      'location': location,
      'is_favorite': isFavorite,
      'isAdopted': isAdopted,
      'description': description,
      'rate': rate,
      'id': id,
      'price': price,
      'owner_name': ownerName,
      'owner_photo': ownerPhoto,
      'sex': sex,
      'age': age,
      'color': color,
      'album': album,
      'isVisited': isVisited,
      'index': index,
      'weight': weight,
      'date': date,
    };
  }

  // CopyWith method to update only the necessary fields
  Pet copyWith({
    String? image,
    String? name,
    String? location,
    bool? isFavorite,
    String? description,
    double? rate,
    String? id,
    String? price,
    String? ownerName,
    String? ownerPhoto,
    String? sex,
    String? age,
    String? color,
    List<String>? album,
    PetType? petType,
    bool? isVisited,
    int? index,
    bool? isAdopted,
    String? weight,
    String? date,
  }) {
    return Pet(
      petType: petType ?? this.petType,
      image: image ?? this.image,
      name: name ?? this.name,
      location: location ?? this.location,
      isFavorite: isFavorite ?? this.isFavorite,
      description: description ?? this.description,
      rate: rate ?? this.rate,
      id: id ?? this.id,
      price: price ?? this.price,
      ownerName: ownerName ?? this.ownerName,
      ownerPhoto: ownerPhoto ?? this.ownerPhoto,
      sex: sex ?? this.sex,
      age: age ?? this.age,
      color: color ?? this.color,
      album: album ?? this.album,
      isVisited: isVisited ?? this.isVisited,
      index: index ?? this.index,
      isAdopted: isAdopted ?? this.isAdopted,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }
}

// Function to map string to PetType
PetType getPetTypeFromString(String petTypeString) {
  try {
    return PetType.values.firstWhere(
      (e) => e.toString().split('.').last == petTypeString,
      orElse: () => PetType.other,
    );
  } catch (e) {
    return PetType.other;
  }
}

// Enum for PetType
enum PetType {
  dog,
  cat,
  rabbit,
  bird,
  fish,
  other,
  all,
}
