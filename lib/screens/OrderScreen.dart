import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/widget/OrderItem.dart';

import '../model/Order.dart';
import '../widget/CardItem.dart';
import '../widget/Drawer.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const route='/orderScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(title: const Text("Your Order"),
      ),
      body: FutureBuilder(future: Provider.of<Orders>(context,listen: false).getData(),builder: (context,data){
        if(data.hasError)
        {
          return const Center(child: Text("Error"),);
        }else if (data.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }else if(data.connectionState==ConnectionState.done)
        {
          return
            Consumer<Orders>(builder: (_,order,child)
            {
              print(order.items.length);
              return ListView.builder(itemBuilder: (ctx,i)=>Orderitem(order.items[i],),itemCount: order.items.length,)
            ;});
        }
        return Center();
      }) ,
    );
  }
}
