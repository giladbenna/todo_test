import 'package:flutter/material.dart';
import 'package:todo_test/controllers/recipe_detail_controller.dart';
import 'package:todo_test/models/recipe.dart';
import 'package:todo_test/models/recipe_details.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailsPage extends StatefulWidget {
  final Recipe recipe;
  final RecipeDetailsController recipeDetailsController =
      RecipeDetailsController();

  RecipeDetailsPage({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  late Future<RecipeDetails> _recipeDetailsFuture;

  @override
  void initState() {
    super.initState();
    _recipeDetailsFuture =
        widget.recipeDetailsController.fetchRecipeDetails(widget.recipe.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: FutureBuilder<RecipeDetails>(
        future: _recipeDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final recipeDetails = snapshot.data!;
            return ListView(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(recipeDetails.lightImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(15),
                      top: Radius.circular(15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              recipeDetails.foodBlogger.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  recipeDetails.foodBlogger.lightProfileImage),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              _launchURL(
                                  recipeDetails.foodBlogger.instagramLink);
                            },
                            icon: const Icon(
                              Icons.facebook,
                              color: Colors.blue,
                            ),
                            label: Text(
                              recipeDetails.foodBlogger.instagramName,
                              style: const TextStyle(color: Colors.lightBlue),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            onPressed: () {
                              _launchURL(recipeDetails.foodBlogger.tiktokLink);
                            },
                            icon: const Icon(
                              Icons.tiktok,
                              color: Colors.black,
                            ),
                            label: Text(
                              recipeDetails.foodBlogger.tiktokName,
                              style: const TextStyle(color: Colors.lightBlue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        recipeDetails.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        recipeDetails.description,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '    ${recipeDetails.difficulty.toStringAsFixed(1)}/5        ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            '${recipeDetails.preparationTime} דקות     ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'רמת קושי',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            ' זמן הכנה משוער',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'מצרכים ל- ${recipeDetails.ingredients.length.toStringAsFixed(0)} מנות',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: recipeDetails.ingredients.length,
                          itemBuilder: (context, index) {
                            final ingredient = recipeDetails.ingredients[index];

                            // Check if the ingredientType is 'FOOD'
                            if (ingredient.ingredientType == 'FOOD') {
                              return CheckboxListTile(
                                title: Text(
                                  ingredient.name,
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.right,
                                ),
                                value: ingredient.isSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    ingredient.isSelected = newValue!;
                                  });
                                },
                              );
                            } else {
                              // Return an empty container if the ingredientType is not 'FOOD'
                              return Container();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        ': כלי מטבח',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: recipeDetails.ingredients.length,
                          itemBuilder: (context, index) {
                            final ingredient = recipeDetails.ingredients[index];

                            // Check if the ingredientType is 'FOOD'
                            if (ingredient.ingredientType == 'KITCHEN') {
                              return CheckboxListTile(
                                title: Text(
                                  ingredient.name,
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.right,
                                ),
                                value: ingredient.isSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    ingredient.isSelected = newValue!;
                                  });
                                },
                              );
                            } else {
                              // Return an empty container if the ingredientType is not 'FOOD'
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox(); // Placeholder widget when there's no data
          }
        },
      ),
    );
  }

  // Function to launch URLs
  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
