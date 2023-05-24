import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled10/model/products.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavirote;

  void toggleFavoriteStatus(String _token,userid) async{
    final url=Uri.parse("https://my-first-projectghjg-default-rtdb.firebaseio.com/isFavorate/$userid/$id.json?auth=$_token");
    final old=isFavirote;
    try
    {
      isFavirote=!isFavirote;
      notifyListeners();
      final resp=await put(url,body:json.encode(isFavirote));
      if(resp.statusCode>=400){
        isFavirote=old;
        notifyListeners();

      }
    }
    catch(e)
    {
      isFavirote=old;
      notifyListeners();
    }

  }
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
       this.isFavirote=false});
}
