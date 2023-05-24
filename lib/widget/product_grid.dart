import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/widget/productitem.dart';
import '../model/product.dart';
import '../model/products.dart';


class ProductsGrid extends StatelessWidget {
  final bool showFavirte;
  ProductsGrid(this.showFavirte);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final List<Product> products = !showFavirte?productsData.items:productsData.favirote;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
