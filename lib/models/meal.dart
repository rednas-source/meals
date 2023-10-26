enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

// all values required for a meal.
class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });


  final String id;

  /// Categories the meal belongs to.
  final List<String> categories;

  /// Name of the meal.
  final String title;

  /// URL for the meal's image.
  final String imageUrl;

  /// Ingredients required for the meal.
  final List<String> ingredients;

  /// Steps to prepare the meal.
  final List<String> steps;

  /// Duration in minutes to prepare the meal.
  final int duration;

  /// Complexity of preparing the meal.
  final Complexity complexity;

  /// Affordability level of the meal.
  final Affordability affordability;

  /// Indicates if the meal is gluten-free.
  final bool isGlutenFree;

  /// Indicates if the meal is lactose-free.
  final bool isLactoseFree;

  /// Indicates if the meal is vegan.
  final bool isVegan;

  /// Indicates if the meal is vegetarian.
  final bool isVegetarian;
}
