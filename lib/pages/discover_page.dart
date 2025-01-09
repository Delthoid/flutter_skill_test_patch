import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skill_test_patch/data/app_state_data.dart';
import 'package:flutter_skill_test_patch/data/store_data.dart';
import 'package:flutter_skill_test_patch/enums.dart';
import 'package:flutter_skill_test_patch/model/catergory.dart';
import 'package:flutter_skill_test_patch/model/product.dart';
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
  late Future<List<Product>> fetchProducts;

  @override
  void initState() {
    super.initState();
    initFutures();
  }

  void initFutures() {
    fetchCategories = ref.read(apiServiceProvider).fetchCategories();
    fetchProducts = ref.read(apiServiceProvider).fetchProducts(
          category: ref.read(appStateNotifier).selectedCategory?.key,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(appStateNotifier);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            fetchCategories = ref.read(apiServiceProvider).fetchCategories();
            fetchProducts = ref.read(apiServiceProvider).fetchProducts();
          });
        },
        child: SingleChildScrollView(
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
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error, size: 48, color: Colors.red),
                                const SizedBox(height: 12),
                                Text('Opps! Something went wrong when fetching categories'),
                                const SizedBox(height: 12),
                                FilledButton.tonal(
                                  onPressed: () {
                                    setState(() {
                                      initFutures();
                                    });
                                  },
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ...snapshot.data!.map((category) {
                              return CategoryItem(
                                category: category,
                                isSelected: state.selectedCategory == category,
                                onTap: () {
                                  if (state.selectedCategory == category) {
                                    ref.read(appStateNotifier.notifier).setCategory(category: null);
                                    setState(() {
                                      fetchProducts = ref.read(apiServiceProvider).fetchProducts(category: null);
                                    });
                                    return;
                                  }

                                  ref.read(appStateNotifier.notifier).setCategory(category: category);
                                  setState(() {
                                    fetchProducts = ref.read(apiServiceProvider).fetchProducts(category: category.key);
                                  });
                                },
                              );
                            }),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    FutureBuilder(
                      future: fetchProducts,
                      builder: (context, snapshot) {
                        if (snapshot.hasError && snapshot.connectionState == ConnectionState.done) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Failed to load products'),
                                const SizedBox(height: 16),
                                FilledButton.tonal(
                                  onPressed: () {
                                    setState(() {
                                      initFutures();
                                    });
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        }

                        return Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            //Have a shimmer on this too while wating for products to load
                            Text('${snapshot.connectionState == ConnectionState.waiting ? '--' : snapshot.data?.length} products to choose from', style: theme.textTheme.titleMedium?.copyWith(fontSize: 18.0)),

                            Wrap(
                              spacing: 8,
                              children: PriceSort.values
                                  .map((price) => FilterChip(

                                        label: Text(price.name),
                                        selected: ref.read(appStateNotifier).priceSort == price,
                                        onSelected: (selected) {
                                          if (price == ref.read(appStateNotifier).priceSort) {
                                            ref.read(appStateNotifier.notifier).setPriceSort(priceSort: null);
                                            return;
                                          }
                                          ref.read(appStateNotifier.notifier).setPriceSort(priceSort: price);
                                        },
                                        backgroundColor: ref.read(appStateNotifier).priceSort == price ? Colors.blue : Colors.grey[200],
                                        labelStyle: ref.read(appStateNotifier).priceSort == price ? const TextStyle(color: Colors.white) : const TextStyle(color: Colors.black),
                                      ))
                                  .toList(),
                            ),

                            //Products
                            ProductsList(
                              products: snapshot.data ?? [],
                              isLoading: snapshot.connectionState == ConnectionState.waiting,
                            ),

                            const SizedBox(height: 12),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
