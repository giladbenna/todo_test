class RecipeDetails {
  final int id;
  final String name;
  final String lightImage;
  final int likes;
  final String preparationTime;
  final double rating;
  final String lightBanner;
  final double difficulty;
  final double servings;
  final String chefNotes;
  final String description;
  final FoodBlogger foodBlogger;
  final List<Ingredient> ingredients;
  final List<Direction> directions;

  RecipeDetails({
    required this.id,
    required this.name,
    required this.lightImage,
    required this.likes,
    required this.preparationTime,
    required this.rating,
    required this.lightBanner,
    required this.difficulty,
    required this.servings,
    required this.chefNotes,
    required this.description,
    required this.foodBlogger,
    required this.ingredients,
    required this.directions,
  });

  factory RecipeDetails.fromJson(Map<String, dynamic> json) {
    return RecipeDetails(
      id: json['id'],
      name: json['name'],
      lightImage: json['lightImage'],
      likes: json['likes'],
      preparationTime: json['preparationTime'],
      rating: json['rating'].toDouble(),
      lightBanner: json['lightBanner'],
      difficulty: json['difficulty'].toDouble(),
      servings: json['servings'].toDouble(),
      chefNotes: json['chefNotes'],
      description: json['description'],
      foodBlogger: FoodBlogger.fromJson(json['foodBlogger']),
      ingredients: List<Ingredient>.from(
          json['ingredients'].map((x) => Ingredient.fromJson(x))),
      directions: List<Direction>.from(
          json['directions'].map((x) => Direction.fromJson(x))),
    );
  }
}

class FoodBlogger {
  final String name;
  final String instagramName;
  final String tiktokName;
  final String lightProfileImage;
  final String instagramLink;
  final String tiktokLink;

  FoodBlogger({
    required this.name,
    required this.instagramName,
    required this.tiktokName,
    required this.lightProfileImage,
    required this.instagramLink,
    required this.tiktokLink,
  });

  factory FoodBlogger.fromJson(Map<String, dynamic> json) {
    return FoodBlogger(
      name: json['name'],
      instagramName: json['instagramName'],
      tiktokName: json['tiktokName'],
      lightProfileImage: json['lightProfileImage'],
      instagramLink: json['instagramLink'],
      tiktokLink: json['tiktokLink'],
    );
  }
}

class Ingredient {
  final String name;
  final int location;
  final int id;
  final String barcodeCode;
  final String ingredientType;
  final double quantity;
  bool isSelected; // Add isSelected property

  Ingredient({
    required this.name,
    required this.location,
    required this.id,
    required this.barcodeCode,
    required this.ingredientType,
    required this.quantity,
    this.isSelected = false,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      location: json['location'],
      id: json['id'],
      barcodeCode: json['barcodeCode'],
      ingredientType: json['ingredientType'],
      quantity: json['quantity'].toDouble(),
    );
  }
}

class Direction {
  final int location;
  final int id;
  final String description;

  Direction({
    required this.location,
    required this.id,
    required this.description,
  });

  factory Direction.fromJson(Map<String, dynamic> json) {
    return Direction(
      location: json['location'],
      id: json['id'],
      description: json['description'],
    );
  }
}
