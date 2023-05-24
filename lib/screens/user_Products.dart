import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/model/products.dart';

import '../model/product.dart';
import '../widget/Drawer.dart';
import '../widget/userproductitem.dart';
import 'editproductscreen.dart';

class UserProducts extends StatelessWidget {
  const UserProducts({Key? key}) : super(key: key);
  static const route="/UserProducts";
  Future<void> _fe(BuildContext context)async{
    try {
      await Provider.of<Products>(context,listen: false).getdata(filterby: true);
    }catch(e)
    {
      print(e);
    }

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text("User Products"),
        actions: [IconButton(onPressed: () {Navigator.of(context).pushNamed(EditProductScreen.route);}, icon: const Icon(Icons.add))],
      ),
      body: FutureBuilder(
        future: _fe(context),
        builder: (ctx,pro)
        {
          if (pro.connectionState==ConnectionState.waiting)
          {
            return const Center(child: CircularProgressIndicator(),) ;
          }else{
            return  RefreshIndicator(
              onRefresh: ()=>_fe(context),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Consumer<Products>(
                  builder: (ctx,pro,_)=> ListView.builder(
                    itemCount: pro.len,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          UserProductsItem(id:pro.items[i].id,title: pro.items[i].title,url: pro.items[i].imageUrl,),
                          const Divider()
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          }

        },
      )
    );
  }
}
