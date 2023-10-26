# Meals App

A flutter project about different meal with recipes attached.
The app i designed to view meals from different categories and show you the cooking process of said meal. Additionally, dietary preferances needs to be a priority.

## App Architecture
## User stories
As a user
I want an application which allows me to find the specific recipes.
I also would like for the application to have to give me the option of filtering my different needs, this combined with all the recipes from the different categories, allows me to get the variety i need in my meal planning.

##### What is expected of the app?
- Different Meal Categories
- Recipe of the meal
- filtering (Vegans, vegetarians etc)
- Search for different meals
- Favorite meals
- Navigation drawer for features
- dark mode.

## specifications

- Platform          : Flutter for IOS and Android
- Theme's           : Color theme modes (light and dark)
- Data Source       : Dummy data
- Data Model        : models for meals and categories.
- State management  : Providers are used for centralized state management.

## file and folder structure

```plaintext
meals/
│
├── lib/
│   ├── data/
│   │   └── dummy_data.dart
│   │
│   ├── models/
│   │   ├── category.dart
│   │   └── meal.dart
│   │
│   ├── providers/
│   │   ├── favorites_provider.dart
│   │   ├── filters_provider.dart
│   │   ├── search_meal.dart
│   │   └── meals_provider.dart
│   │
│   ├── screens/
│   │   ├── categories.dart
│   │   ├── filters.dart
│   │   ├── meal_details.dart
│   │   ├── meals.dart
│   │   └── tabs.dart
│   │
│   ├── widgets/
│   │   ├── category_grid_item.dart
│   │   ├── main_drawer.dart
│   │   ├── meal_item.dart
│   │   ├── meal_item_trait.dart
│   │   └── main.dart
│   │
│   └── main.dart
│
├── assets/ (if any)
│
├── pubspec.yaml
└── README.md
```

- **data**: Contains dummy data.
- **models**: Classes and data structures.
- **providers**: Manages state and data throughout the app.
- **screens**: Different screens.
- **widgets**: Components and widgets, best practise for reuasablity.
- **main.dart**: Main function for the application.

## 
