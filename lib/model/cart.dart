import 'package:flutter/widgets.dart';

class CartItem
{
  final String id;
  final String title;
   final int quality;
  final double price;
  CartItem({required this.id,required this.title, required this.quality,required this.price});
}

class Carts with ChangeNotifier
{
  Map<String,CartItem>_Items={};
  Map<String,CartItem> get Items
  {
    return {..._Items};
  }
  void clear()
  {
    _Items.clear();
    notifyListeners();
  }
  void add(String id, double price , String title )
  {
    if(_Items.containsKey(id)) {
      _Items.update(id, (value) => CartItem(id: value.id, title: value.title, quality: value.quality+1, price: value.price));
    } else {
      _Items.putIfAbsent(id, () => CartItem(id: DateTime.now().toString(), title: title, quality: 1, price: price));
    }
    notifyListeners();
  }
  int get zzzzzzzzz{
    return _Items.length ;
  }
  double get sum
  {
    var x=0.0;
     _Items.forEach((key, value) {x+=value.price*value.quality;});
    return x;
  }
  void remove(String id)
  {
    _Items.remove(id);
    notifyListeners();
  }
  void removeSingleItem(String productId) {
    if (!_Items.containsKey(productId)) {
      return;
    }
    if (_Items[productId]!.quality > 1) {
      _Items.update(
          productId,
              (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
                quality: existingCartItem.quality - 1,
          )
      );
    } else {
      _Items.remove(productId);
    }
    notifyListeners();
  }
}