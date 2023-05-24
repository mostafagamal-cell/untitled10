import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/model/products.dart';

import '../screens/editproductscreen.dart';

class UserProductsItem extends StatelessWidget {
  final String title;
  final String id;
  final String url;

  const UserProductsItem({
    Key? key,
    required this.title,
    required this.url, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sc=ScaffoldMessenger.of(context);

    return LayoutBuilder(
      builder: (ctx,constrans){
        return ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(url),
          ),
          trailing: SizedBox(
              width: constrans.maxWidth*.28237,
              child: Row(
                children: [
                  IconButton(onPressed: (){Navigator.of(context).pushNamed( EditProductScreen.route,arguments: id);}, icon: const Icon(Icons.edit),color: Theme.of(context).primaryColor,),
                  IconButton(onPressed: ()async{
                    try{
                    await Provider.of<Products>(context,listen: false).delet(id);
                    }catch(e)
                    {
                    sc.showSnackBar(SnackBar(content: Text(e.toString()),action:SnackBarAction(label: 'Okey', onPressed: () {},)));
                    }
                    }, icon: const Icon(Icons.delete),color: Theme.of(context).colorScheme.error,)
                ],
              ),
            ),

        );
      }
    );
  }
}
