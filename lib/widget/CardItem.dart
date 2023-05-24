import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';

class Carditem extends StatelessWidget {
  const Carditem(
      {Key? key,
      required this.id,
      required this.price,
      required this.quantity,
      required this.titel,
      required this.proId})
      : super(key: key);
  final String id;
  final String proId;
  final double price;
  final int quantity;
  final String titel;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Are you sure"),
                content: const Text("Do you want remove item"),
                actions: [
                  TextButton(onPressed: () {Navigator.of(ctx).pop(false);}, child: const Text("NO")),
                  TextButton(onPressed: () {Navigator.of(ctx).pop(true);}, child: const Text("YES"))
                ],
              );
            }).then((value) => value);
      },
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete),
      ),
      onDismissed: (direction) =>
          Provider.of<Carts>(context, listen: false).remove(proId),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: FittedBox(child: Text("$price \$")),
            ),
          ),
          title: Text(titel),
          subtitle: Text("Total \$${price * quantity}"),
          trailing: Text("$quantity x"),
        ),
      ),
    );
  }
}
