import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:untitled10/model/products.dart';

import 'cart.dart';

class OrderItem
{
  final String id;
  final double amount;
  final List<CartItem>products;
  final DateTime dateTime;
  OrderItem({required this.id, required this.amount, required this.products, required this.dateTime});
}
class Orders with ChangeNotifier
{
  final _token;
  final id;
  Orders(this._token,_items, this.id);
  List<OrderItem> _items=[];
  List<OrderItem> get items
  {
    return[..._items];
  }
  Future<void> add(List<CartItem>cart,double total)
  async{
    final url=Uri.parse("https://my-first-projectghjg-default-rtdb.firebaseio.com/Orders/$id.json?auth=$_token");
    final date=DateTime.now();
    try
    {
      final respns=await post(url,body: json.encode({
        'amount': total,
        'datetime':date.toIso8601String(),
        'prodcts':cart.map((e) => {
          'id':e.id,
          'price':e.price,
          'quality':e.quality,
          'title':e.title
        }).toList()
      }));
print(respns.statusCode);

    }catch(e)
    {
      print(e);
    }
    _items.insert(0,OrderItem(id: date.toString(), amount: total, products: cart, dateTime: DateTime.now()));
     notifyListeners();
  }
  void clear(){_items.clear();notifyListeners();}
  Future<void> getData() async
  {
    List<OrderItem>order=[];
    final url=Uri.parse("https://my-first-projectghjg-default-rtdb.firebaseio.com/Orders/$id.json?auth=$_token");
    try{
      final bo=await get(url);


      final loadeddata=json.decode(bo.body) as Map<String ,dynamic>?;
      print(loadeddata);
      if(loadeddata==null||loadeddata.isEmpty) {
        _items.clear();
        print("order lenth is");
        print(order.length);
        print("==============");
        notifyListeners();
        return;
      }

      loadeddata.forEach((key, value) {
        order.add(OrderItem(id: key, amount: value['amount'], products: (value['prodcts'] as List<dynamic>).map((e) => CartItem(id: key, title: e['title'], quality: e['quality'], price: e['price'])).toList(), dateTime: DateTime.parse(value['datetime'])));
      });
    _items=order;
    notifyListeners();
    }catch(e)
    {
    rethrow;
    }


  }
}
