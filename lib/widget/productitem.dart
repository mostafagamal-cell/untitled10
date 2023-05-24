import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/model/cart.dart';
import 'package:untitled10/screens/productscreen.dart';

import '../model/product.dart';
import '../model/products.dart';

class ProductItem extends StatefulWidget {

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final pro=Provider.of<Products>(context);
    final item=Provider.of<Carts>(context,listen: false);
    final items=Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadiusDirectional.circular(15),
      child: GestureDetector(
        onTap: () {Navigator.of(context).pushNamed(ProductDetailScreen.route,arguments: {'id':items.id});},
        child: GridTile(footer: GridTileBar(
          backgroundColor: Colors.black26,
          trailing:IconButton(icon:
           const Icon( Icons.shopping_cart), onPressed: (){
            item.add(items.id, items.price, items.title);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: const Text("Item is added"),
            action: SnackBarAction(label: "Undo", onPressed: ()=>item.removeSingleItem(items.id)),
            )
            )
            ;

          },color: Theme.of(context).colorScheme.secondary),
          leading: IconButton(icon:  Icon(items.isFavirote?Icons.favorite:Icons.favorite_border_outlined), onPressed:(){
            items.toggleFavoriteStatus(pro.token,pro.userid);
            pro.notifyListeners();
          }),
          title: Text(items.title,textAlign: TextAlign.center),
        ),child: Hero(tag: items.id,child: FadeInImage(placeholder: const AssetImage('assets/images/p.png'),image: NetworkImage(items.imageUrl),fit:BoxFit.cover)) ,),
      ),
    );
  }
}
//