import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/screens/OrderScreen.dart';
import 'package:untitled10/screens/user_Products.dart';

import '../model/auth.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        AppBar(title: const Text("Hello frindes"),
        automaticallyImplyLeading: false,),
        const Divider(),
        ListTile(title: const Text("Shop"),leading: const Icon(Icons.shopping_cart),onTap: (){Navigator.of(context).pushReplacementNamed('/');},)
        ,const Divider(),
        ListTile(title: const Text("Order"),leading: const Icon(Icons.wallet),onTap: (){Navigator.of(context).pushReplacementNamed(OrderScreen.route);},)
        ,const Divider()
        ,ListTile(title: const Text("Mange Prodcts"),leading: const Icon(Icons.edit),onTap: (){Navigator.of(context).pushReplacementNamed(UserProducts.route);},)
        ,const Divider()
        ,ListTile(title: const Text("logout"),leading: const Icon(Icons.logout),onTap: (){
          Navigator.of(context).pushReplacementNamed('/');
          Provider.of<Auth>(context,listen: false).logout();},)

      ],),
    );
  }
}
