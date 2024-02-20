import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_test/models/recipe_details.dart';

class RecipeDetailsController {
  Future<RecipeDetails> fetchRecipeDetails(int recipeId) async {
    final String apiUrl =
        'http://195.28.181.14:8080/todoServer/recipes/details/$recipeId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> jsonData = json.decode(responseBody);
        return RecipeDetails.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch recipe details');
      }
    } catch (e) {
      throw Exception('Failed to fetch recipe details: $e');
    }
  }
}
