import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/model/cart.dart';
import 'package:untitled10/widget/CardItem.dart';

import '../model/Order.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const route = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Carts>(context);
    return Scaffold(
        appBar: AppBar(title: const Text("Shopping")),
        body: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 22),
                    ),
                    Chip(
                      label: Text(
                          style: const TextStyle(fontSize: 22),
                          data.sum.toString()),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                   OrderNow(data)
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (ctx, i) {
                return Carditem(
                  proId: data.Items.keys.toList()[i],
                  id: data.Items.values.toList()[i].id,
                  price: data.Items.values.toList()[i].price,
                  quantity: data.Items.values.toList()[i].quality,
                  titel: data.Items.values.toList()[i].title,
                );
              },
              itemCount: data.Items.length,
            ))
          ],
        ));
  }
}

class OrderNow extends StatefulWidget {
  final Carts data;
  OrderNow(this.data);
  @override
  State<OrderNow> createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  bool isloading=false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  OutlinedButton(
       onPressed: isloading||widget.data.zzzzzzzzz<=0?null:() async {
         setState(() {
           isloading=true;
         });
         await Provider.of<Orders>(context, listen: false)
             .add(widget.data.Items.values.toList(), widget.data.sum);
         widget.data.clear();
         setState(() {
           isloading=false;
         });
       },
       child: isloading?const FittedBox(child: CircularProgressIndicator()):const Text("Order Now"));
  }
}
