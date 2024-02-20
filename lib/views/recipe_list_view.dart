import 'package:flutter/material.dart';
import 'package:todo_test/controllers/recipe_controller.dart';
import 'package:todo_test/models/recipe.dart';
import 'package:todo_test/views/recipe_card.dart';

class RecipeListView extends StatefulWidget {
  const RecipeListView({super.key});

  @override
  _RecipeListViewState createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  final RecipeController recipeController = RecipeController();
  late List<Recipe> _allRecipes;
  late List<Recipe> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    try {
      final recipes = await recipeController.fetchRecipes();
      setState(() {
        _allRecipes = recipes;
        _filteredRecipes = List.from(recipes);
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  void _filterRecipesByCategory(String category) {
    setState(() {
      _filteredRecipes = _allRecipes
          .where(
              (recipe) => recipe.subCategories.contains(category.toUpperCase()))
          .toList();
    });
  }

  void _filterRecipesBySearch(String searchQuery) {
    setState(() {
      _filteredRecipes = _allRecipes
          .where((recipe) =>
              recipe.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: _filterRecipesBySearch,
            decoration: const InputDecoration(
              labelText: 'Search recipes',
              hintText: 'Enter recipe name...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => _filterRecipesByCategory('PASTA'),
                child: const Text('פסטה'), // Replace with Hebrew text
              ),
              ElevatedButton(
                onPressed: () => _filterRecipesByCategory('PIZZA'),
                child: const Text('פיצה'), // Replace with Hebrew text
              ),
              ElevatedButton(
                onPressed: () => _filterRecipesByCategory('SALAD'),
                child: const Text('סלטים'), // Replace with Hebrew text
              ),
              ElevatedButton(
                onPressed: () => _filterRecipesByCategory('APPETIZER'),
                child: const Text('ראשונות'), // Replace with Hebrew text
              ),
              ElevatedButton(
                onPressed: () => _filterRecipesByCategory('PASTRY'),
                child: const Text('מאפים'), // Replace with Hebrew text
              ),
              // Add more buttons for other categories
            ],
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: _filteredRecipes.length,
            itemBuilder: (context, index) {
              final recipe = _filteredRecipes[index];
              return RecipeCard(recipe: recipe);
            },
          ),
        ),
      ],
    );
  }
}
