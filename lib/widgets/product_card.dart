import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              'Product Name',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              //To simulate long description
              'This is a sample of product description. So this is me swallowing my pride standing in front of you saying I am sorry for that night. And I go back to December all the time.',
              style: TextStyle(fontSize: 10),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text('\$ 100.00', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          )
        ],
      ),
    );
  }
}