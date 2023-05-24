import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/screens/cartScreen.dart';
import 'package:untitled10/widget/Drawer.dart';
import 'package:untitled10/widget/badge.dart';
import '../model/cart.dart';
import '../model/products.dart';
import '../widget/product_grid.dart';

class ProductOverviewScreen extends StatefulWidget {
  static const route = '/overviewscreen';

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool showFavorate = false;
  bool isloading=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyShop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (selectedValue) {
                setState(() {
                  if (selectedValue == 1) {
                    showFavorate = true;
                  } else {
                    showFavorate = false;
                  }
                });
              },
              icon: const Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Only Favorites'),
                ),
                const PopupMenuItem(
                  value: 0,
                  child: Text('Show All'),
                ),
              ],
            ),
            Consumer<Carts>(
              builder: (_, cart, ch) => Badge(
                value: cart.zzzzzzzzz.toString(), child: ch!,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {Navigator.of(context).pushNamed(CartScreen.route);},
              ),
            ),
          ],
        ),
        drawer: const MainDrawer(),
        body:!isloading?ProductsGrid(showFavorate)
        :const Center(child: CircularProgressIndicator())
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(isloading) {
      setState(() {

      });
      try {
     Provider.of<Products>(context).getdata().then((value) {setState(() {
       isloading=false;
     });});
      } catch (e) {
        print(e);
      }
    }
  }
}
