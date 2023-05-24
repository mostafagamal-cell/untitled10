
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled10/model/HTTPEXPCTION.dart';
import 'package:untitled10/model/product.dart';
import 'dart:convert';

class Products with ChangeNotifier
{
  final token;
  final userid;
  Products(this.token,this._items,this.userid);
   List<Product>_items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),

  ];
  List<Product> get favirote => _items.where((element) => element.isFavirote==true).toList();
   get items
  {
   return [..._items];
  }
  get len
  {
    return _items.length;
  }
  Future<void>getdata({filterby=false}) async
  {
  final filter= filterby==false?'':'&orderBy="creatorid"&equalTo="$userid"';
    final url=Uri.parse('https://my-first-projectghjg-default-rtdb.firebaseio.com/Products.json?auth=$token$filter');
    final url2=Uri.parse("https://my-first-projectghjg-default-rtdb.firebaseio.com/isFavorate/$userid.json?auth=$token");
    try {
      List<Product>p=[];
      final js=await get(url);
      final js2=await get(url2);
      final rs=json.decode(js2.body);
      print("=========================");
      print(js2.body);
      print("=========================");
      final respons =  json.decode(js.body) as Map<String,dynamic>;
      respons.forEach((key, value) {
        p.add(Product(id: key,
            title: value['title'],
            description: value['description'],
            price:  value['price'],
            isFavirote:(rs==null)?false:(rs[key]==null||rs[key]==false)?false:true,
            imageUrl:  value['imageUrl']));

      });

      print(p.toString());
      _items=p;
      notifyListeners();
    }catch(e)
    {
      print(e);
      rethrow;
    }


  }
  Future<void> add(Product p) async
  {
    final url=Uri.parse("https://my-first-projectghjg-default-rtdb.firebaseio.com/Products.json?auth=$token");

    try{
    var respons= await post(url,body: json.encode(
        {'title':p.title,
          'creatorid':userid,
          'description':p.description,
          'price': p.price, 'imageUrl':
        p.imageUrl, 'id': DateTime.now().toString(),
          'isfavorate':p.isFavirote}));
        var ne=Product(id: json.decode(respons.body)['name'], title: p.title, description: p.description, price: p.price, imageUrl: p.imageUrl);
      _items.insert(0,ne);
      notifyListeners();
      notifyListeners();
  }catch (e )
    {
      rethrow;
    }

   }
  Product findbyid(_)
  {
  return _items.firstWhere((element) => element.id==_);
  }



  Future<void> updateProduct(String id, Product p) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url=Uri.parse("https://my-first-projectghjg-default-rtdb.firebaseio.com/Products/$id.json?auth=$token");
      try {
        await patch(url, body: json.encode(
            {
              'title': p.title,
              'description': p.description,
              'price': p.price,
              'imageUrl': p.imageUrl,
              'id': DateTime.now().toString(),
              'isfavorate': p.isFavirote
            }));

        _items[prodIndex] = p;
        notifyListeners();
      }catch (e)
      {
        print(e);
        rethrow;
      }
    } else {
      print('...');
    }
  }
  Future<void> delet(String id) async {
    final  url=  Uri.https('my-first-projectghjg-default-rtdb.firebaseio.com','/Products/$id.json');
    final indx=_items.indexWhere((element) => element.id==id);
    Product? e=_items.elementAt(indx);
      final resp= await delete(url);
      if(resp.statusCode>=400){
      throw const HttpsExcption(messge: "Could not  delete item");
      }
       e=null;
      _items.removeAt(indx);
    notifyListeners();
  }
}