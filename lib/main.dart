import 'package:flutter/material.dart';

import 'package:todo_test/views/recipe_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TODO_TEST'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200, // Adjust the height according to your requirement
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://imageproxy.wolt.com/venue/6232faaafd94b762808350de/ebcc50b6-a903-11ec-8d84-92cd96cd4d02_habib3.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Expanded(
              child:
                  RecipeListView(), // Assuming RecipeListView is a widget showing categories and recipes
            ),
          ],
        ),
      ),
    );
  }
}
