class Recipe {
  final int id;
  final String lightImage;
  final String darkImage;
  final String name;
  final bool popular;
  final String preparationTime;
  final int likes;
  final bool promoted;
  final double rating;
  final int foodBloggerId;
  final String tiktokName;
  final String instagramName;
  final String foodBloggerName;
  final String foodBloggerShortDescription;
  final List<String> subCategories;

  Recipe({
    required this.id,
    required this.lightImage,
    required this.darkImage,
    required this.name,
    required this.popular,
    required this.preparationTime,
    required this.likes,
    required this.promoted,
    required this.rating,
    required this.foodBloggerId,
    required this.tiktokName,
    required this.instagramName,
    required this.foodBloggerName,
    required this.foodBloggerShortDescription,
    required this.subCategories,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      lightImage: json['lightImage'],
      darkImage: json['darkImage'],
      name: json['name'],
      popular: json['popular'],
      preparationTime: json['preparationTime'],
      likes: json['likes'],
      promoted: json['promoted'],
      rating: json['rating'].toDouble(),
      foodBloggerId: json['foodBloggerId'],
      tiktokName: json['tiktokName'],
      instagramName: json['instagramName'],
      foodBloggerName: json['foodBloggerName'],
      foodBloggerShortDescription: json['foodBloggerShortDescription'],
      subCategories: List<String>.from(json['subCategories']),
    );
  }
}
