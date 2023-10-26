import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

/// Represents a screen where users can apply different filters to meal options.
class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: Column(
        children: [
          // A SwitchListTile to enable/disable gluten-free filter
          _buildSwitchListTile(
            context: context,
            ref: ref,
            filter: Filter.glutenFree,
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
          ),
          // A SwitchListTile to enable/disable lactose-free filter
          _buildSwitchListTile(
            context: context,
            ref: ref,
            filter: Filter.lactoseFree,
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
          ),
          // A SwitchListTile to enable/disable vegetarian filter
          _buildSwitchListTile(
            context: context,
            ref: ref,
            filter: Filter.vegetarian,
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
          ),
          // A SwitchListTile to enable/disable vegan filter
          _buildSwitchListTile(
            context: context,
            ref: ref,
            filter: Filter.vegan,
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchListTile({
    required BuildContext context,
    required WidgetRef ref,
    required Filter filter,
    required String title,
    required String subtitle,
  }) {
    final activeFilter = ref.watch(filtersProvider.select((filters) => filters[filter]!));
    return SwitchListTile(
      value: activeFilter,
      onChanged: (isChecked) => ref.read(filtersProvider.notifier).setFilter(filter, isChecked),
      title: Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground)),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground)),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
