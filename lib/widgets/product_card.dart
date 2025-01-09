import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skill_test_patch/model/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0XFFCACACA)),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        spacing: 3,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: product.image == null ? const SizedBox.shrink() : CachedNetworkImage(
              imageUrl: product.image ?? '',
              progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              product.title ?? '',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              product.description ?? '',
              style: TextStyle(fontSize: 10),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          if (product.price != null)
            SizedBox(
              width: double.infinity,
              child: Text('\$${product.price?.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            )
        ],
      ),
    );
  }
}