import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';  // Importing data source
import 'package:meals/models/category.dart';  // Importing category model
import 'package:meals/models/meal.dart';      // Importing meal model
import 'package:meals/screens/meals.dart';     // Importing MealsScreen
import 'package:meals/widgets/category_grid_item.dart';  // Importing CategoryGridItem widget

/// Displays a grid of meal categories.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// Class for the category screen.
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;  // Animation controller for screen transition
  final TextEditingController _searchController = TextEditingController();  // Controller for the search input
  List<Meal> filteredMeals = [];  // List to store filtered meals
  bool showSearchResults = false;  // Indicates whether search results are displayed

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for screen transition
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the screen is no longer in use
    _animationController.dispose();
    super.dispose();
  }

  // Function to handle search input changes
  void onSearch(String value) {
    setState(() {
      if (value.isNotEmpty) {
        // If search query is not empty, show search results
        showSearchResults = true;
        filteredMeals = widget.availableMeals.where((meal) {
          return meal.title.toLowerCase().contains(value.toLowerCase());
        }).toList();
      } else {
        // If search query is empty, hide search results
        showSearchResults = false;
        filteredMeals.clear();
      }
    });
  }

  // Function to clear the search input and hide search results
  void clearSearch() {
    setState(() {
      _searchController.clear();
      showSearchResults = false;
      filteredMeals.clear();
    });
  }

  // Function to select a category and navigate to the MealsScreen
  void selectCategory(BuildContext context, Category category) {
    // Filter meals based on the selected category
    filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Perform a search with the first meal title from the filtered list
    onSearch(filteredMeals.isNotEmpty ? filteredMeals[0].title : '');

    // Navigate to the MealsScreen with filtered meals
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      labelText: 'Search Meals',
                      prefixIcon: const Icon(Icons.search),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: onSearch,
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[700],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: clearSearch,
                    ),
                  ),
              ],
            ),
          ),
          if (showSearchResults)
            Expanded(
              child: ListView.builder(
                itemCount: filteredMeals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      // Navigate to the MealsScreen with the selected meal
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MealsScreen(
                            title: filteredMeals[index].title,
                            meals: [filteredMeals[index]],
                          ),
                        ),
                      );
                    },
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(filteredMeals[index].imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Image.network(filteredMeals[index].imageUrl),
                    ),
                    title: Text(
                      filteredMeals[index].title,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          if (!showSearchResults)
            Expanded(
              child: GridView(
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: [
                  for (final category in availableCategories)
                    CategoryGridItem(
                      category: category,
                      onSelectCategory: () {
                        selectCategory(context, category);
                      },
                    ),
                ],
              ),
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
