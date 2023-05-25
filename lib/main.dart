import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled10/model/Order.dart';
import 'package:untitled10/model/auth.dart';
import 'package:untitled10/model/cart.dart';
import 'package:untitled10/screens/OrderScreen.dart';
import 'package:untitled10/screens/auth_screen.dart';
import 'package:untitled10/screens/cartScreen.dart';
import 'package:untitled10/screens/editproductscreen.dart';
import 'package:untitled10/screens/productoverviewscreen.dart';
import 'package:untitled10/screens/productscreen.dart';
import 'package:untitled10/screens/splash_screen.dart';
import 'package:untitled10/screens/user_Products.dart';

import 'model/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Carts(),),
        ChangeNotifierProvider.value(value:Auth()),
        ChangeNotifierProxyProvider<Auth,Products>(create: (_)=>Products("", [],""), update: (ctx,dy,x){
          return Products(dy.Token,x?.items,dy.id);
        }),
        ChangeNotifierProxyProvider<Auth,Orders>(create: (_)=>Orders("", [],""), update: (ctx,dy,x){
          return Orders(dy.Token,x?.items,dy.id);
        })
      ],
      child:Consumer<Auth>(builder: (context,data,_)=> MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.deepOrange, background: Colors.black),
        ),
        home: data.isAuth()?ProductOverviewScreen():  FutureBuilder(
          future: data.trylogin(),
          builder: (ctx, authResultSnapshot) {
            if(authResultSnapshot.connectionState == ConnectionState.waiting ){
          return SplashScreen();
          }else
          {
            return AuthScreen();
          }
           }
        ),
        routes: {
          EditProductScreen.route:(context)=> EditProductScreen(),
          UserProducts.route:(context)=>const UserProducts(),
          ProductOverviewScreen.route: (context) => ProductOverviewScreen(),
          ProductDetailScreen.route: (context) => ProductDetailScreen(),
          CartScreen.route: (context) => const CartScreen(),
          OrderScreen.route:(context)=>const OrderScreen()
        },
      ),)
    );
  }
}
