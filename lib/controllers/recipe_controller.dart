import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_test/models/recipe.dart';

class RecipeController {
  Future<List<Recipe>> fetchRecipes() async {
    const String apiUrl =
        'http://195.28.181.14:8080/todoServer/recipes/getAllRecipes';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseBody =
            utf8.decode(response.bodyBytes); // Decode response body
        final List<dynamic> jsonData = json.decode(responseBody);
        return jsonData.map((data) => Recipe.fromJson(data)).toList();
      } else {
        throw Exception('Failed to fetch recipes');
      }
    } catch (e) {
      throw Exception('Failed to fetch recipes: $e');
    }
  }
}
