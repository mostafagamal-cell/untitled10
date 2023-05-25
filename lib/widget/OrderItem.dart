import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/Order.dart' as cs;
import 'dart:math';

class Orderitem extends StatefulWidget {
  final cs.OrderItem order;

  Orderitem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<Orderitem> {
  var _expanded = false;


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
        height: _expanded?min(widget.order.products.length * 20.0 + 110, 200):100,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed:widget.order.amount >0? () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }:null,
              ),
            ),
            
              AnimatedContainer(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: _expanded?min(widget.order.products.length * 20.0 + 10, 200):0,
                duration:  const Duration(milliseconds: 300),
                child: ListView(
                  children: widget.order.products
                      .map(
                        (prod) =>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              prod.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${prod.quality}x \$${prod.price}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                  )
                      .toList(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
