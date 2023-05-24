import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../model/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const route = '/product';
  late final args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments;
    final list = Provider.of<Products>(context, listen: false);
    final Product it = list.findbyid(args['id']);
    return Scaffold(body: LayoutBuilder(builder: (context, constrains) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(it.title),
              background: SizedBox(
                height: constrains.maxHeight * .5,
                width: constrains.maxWidth,
                child: Hero(
                    tag: it.id,
                    child: Image.network(
                      it.imageUrl,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: constrains.maxHeight * .06,
            ),
            Text(
              "\$${it.price}",
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  decorationStyle: TextDecorationStyle.wavy),
            ),
            SizedBox(
              height: constrains.maxHeight * .03,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                it.description,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            )
          ,const SizedBox(height: 900,)]
              )
          )
        ],
      );
    }));
  }
}
