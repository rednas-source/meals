import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/data/dummy_data.dart';
/// Provides access to the list of available meals.
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
