import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skill_test_patch/data/app_state_data.dart';
import 'package:flutter_skill_test_patch/enums.dart';
import 'package:flutter_skill_test_patch/model/product.dart';
import 'package:flutter_skill_test_patch/widgets/product_card.dart';
import 'package:shimmer/shimmer.dart';

class ProductsList extends ConsumerStatefulWidget {
  const ProductsList({required this.products, required this.isLoading, super.key});

  final List<Product> products;
  final bool isLoading;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsListState();
}

class _ProductsListState extends ConsumerState<ProductsList> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appStateNotifier);
    final sortedProducts = <Product>[];

    if (state.priceSort == PriceSort.lowToHigh) {
      sortedProducts.addAll(widget.products..sort((a, b) => a.price?.compareTo(b.price ?? 0) ?? 0));
    } else if (state.priceSort == PriceSort.highToLow) {
      sortedProducts.addAll(widget.products..sort((a, b) => b.price?.compareTo(a.price ?? 0) ?? 0));
    } else {
      sortedProducts.addAll(widget.products..sort((a, b) => a.id?.compareTo(b.id ?? 0) ?? 0));
    }

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 240,
        mainAxisExtent: 270,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12
      ),
      itemCount: widget.isLoading ? 4 : sortedProducts.length,
      itemBuilder: (BuildContext context, int index) {
        if (widget.isLoading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ProductCard(product: Product()),
          );
        }

        return ProductCard(product: sortedProducts[index]);
      },
    );
  }
}