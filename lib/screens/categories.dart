import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

/// Displays a grid of meal categories.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    required this.availableMeals,
  }) ;

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  TextEditingController _searchController = TextEditingController();
  List<Meal> filteredMeals = [];
  bool showSearchResults = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onSearch(String value) {
    setState(() {

      if (value.isNotEmpty) {
        showSearchResults = true;
        filteredMeals = widget.availableMeals.where((meal) {
          return meal.title.toLowerCase().contains(value.toLowerCase());
        }).toList();
      } else {

        showSearchResults = false;
        filteredMeals.clear();
      }
    });
  }

  void clearSearch() {
    setState(() {
      _searchController.clear();
      showSearchResults = false;
      filteredMeals.clear();
    });
  }

  void selectCategory(BuildContext context, Category category) {

    filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    onSearch(filteredMeals.isNotEmpty ? filteredMeals[0].title : '');

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
                      prefixIcon: Icon(Icons.search),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: onSearch,
                  )

                ),
                if (_searchController.text.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[700],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.clear),
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
                          child: Image.network(filteredMeals[index].imageUrl)),
                      title: Text(
                        filteredMeals[index].title,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                )

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
                    )
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