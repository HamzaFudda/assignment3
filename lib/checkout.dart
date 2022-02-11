import 'dart:math';
import 'package:assignment3/dishes.dart';
import 'package:flutter/material.dart';

class checkout extends StatefulWidget {
  final Function(List<dish>) onPressedUpdate;
  final List<dish> checkoutDishes;

  const checkout(
      {Key? key, required this.checkoutDishes, required this.onPressedUpdate})
      : super(key: key);

  @override
  _checkoutState createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  List<dish> tempList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Checkout"),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text("Checkout", style: new TextStyle(fontSize: 28)),
            SizedBox(
              height: 40,
            ),
            Expanded(child: _listBuilder(context)),
          ],
        ));
  }

  ListView _listBuilder(context) {
    final _random = Random();
    return ListView.builder(
      itemCount: widget.checkoutDishes.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: ListTile(
            title: Row(children: [
              Text(widget.checkoutDishes[index].name),
            ]),
            subtitle: Text(widget.checkoutDishes[index].description +
                " " +
                widget.checkoutDishes[index].price.toString()),
            leading: CircleAvatar(
              child: Text(widget.checkoutDishes[index].name.substring(0, 1)),
            ),
            trailing: IconButton(
                iconSize: 30,
                color: Colors.red,
                icon: Icon(Icons.remove_circle_rounded),
                onPressed: () async {
                  bool isRemove = false;
                  isRemove = await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Do you want to remove this dish?'),
                            content: Text('This will remove it from the cart.'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    widget.checkoutDishes
                                        .remove(widget.checkoutDishes[index]);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('No')),
                            ],
                          ));
                  setState(() {});
                  widget.onPressedUpdate(widget.checkoutDishes);
                })),
      ),
    );
  }
}
