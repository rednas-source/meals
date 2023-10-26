import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';

class SearchMeal extends SearchDelegate {
  final List<Meal> _meals;

  SearchMeal(this._meals);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildMealList(
      context,
      _getFilteredMeals(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildMealList(
      context,
      _getFilteredMeals(query),
    );
  }

  List<Meal> _getFilteredMeals(String searchTerm) {
    return _meals
        .where((meal) => meal.title.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }

  Widget _buildMealList(BuildContext context, List<Meal> meals) {
    return ListView.separated(
      itemCount: meals.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final meal = meals[index];
        return ListTile(
          title: Text(meal.title),
          onTap: () => _navigateToMealDetails(context, meal),
        );
      },
    );
  }

  void _navigateToMealDetails(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealDetailsScreen(meal: meal),
    ));
  }
}
