import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skill_test_patch/data/app_state_data.dart';
import 'package:flutter_skill_test_patch/data/store_data.dart';
import 'package:flutter_skill_test_patch/enums.dart';
import 'package:flutter_skill_test_patch/model/catergory.dart';
import 'package:flutter_skill_test_patch/widgets/category_item.dart';
import 'package:flutter_skill_test_patch/widgets/header_with_search_bar.dart';
import 'package:flutter_skill_test_patch/widgets/products_list.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverPage extends ConsumerStatefulWidget {
  const DiscoverPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage> {
  late Future<List<Category>>? fetchCategories;

  @override
  void initState() {
    super.initState();
    fetchCategories = ref.read(apiServiceProvider).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(appStateNotifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWithSearchBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose from any category', style: theme.textTheme.titleMedium?.copyWith(fontSize: 18.0)),

                  //Categories
                  FutureBuilder(
                    future: fetchCategories,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ...List.generate(
                              4,
                              (_) {
                                return Shimmer(
                                  gradient: LinearGradient(colors: [Colors.grey, Colors.white, Colors.grey, Colors.white]),
                                  child: Container(
                                    width: 85,
                                    height: 85,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }

                      if (snapshot.hasError) {
                        return Text('Opps! Something went wrong');
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...snapshot.data!.map((category) {
                            return CategoryItem(
                              category: category,
                              isSelected: state.selectedCategory == category,
                              onTap: () => ref.read(appStateNotifier.notifier).setCategory(category: category),
                            );
                          }),
                        ],
                      );
                    },
                  ),

                  //Results
                  const SizedBox(height: 12),
                  Text('10 products to choose from', style: theme.textTheme.titleMedium?.copyWith(fontSize: 18.0)),
                  Wrap(
                    spacing: 12,
                    children: PriceSort.values
                        .map(
                          (price) => FilterChip(
                            selected: ref.read(appStateNotifier).priceSort == price,
                            label: Text(price.name),
                            onSelected: (_) => ref.read(appStateNotifier.notifier).setPriceSort(priceSort: price),
                            selectedColor: theme.colorScheme.primary,
                            labelStyle: ref.read(appStateNotifier).priceSort == price ? TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                          ),
                        )
                        .toList(),
                  ),

                  //Products
                  ProductsList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
