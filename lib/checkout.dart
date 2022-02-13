import 'dart:math';
import 'package:assignment3/dishes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  // List<dish> tempList = [];

  //Function to calculate total bill of the items in the cart
  double calTotal() {
    double total = 0;
    for (dish items in widget.checkoutDishes) {
      total = total + items.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: Container(
          //decoration: BoxDecoration(color: Colors.grey),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text("Checkout", style: new TextStyle(fontSize: 28)),
              SizedBox(
                height: 40,
              ),
              Expanded(child: _listBuilder(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Bill: " + calTotal().toString() + " Rs",
                    style: new TextStyle(fontSize: 28),
                  ),
                ],
              ),
              //sizedbox to enhance UI
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ));
  }

  ListView _listBuilder(context) {
    //final _random = Random();
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
              child: Text(widget.checkoutDishes[index].name.substring(0, 1) +
                  "" +
                  widget.checkoutDishes[index].name.substring(
                      widget.checkoutDishes[index].name.indexOf(" ") + 1,
                      widget.checkoutDishes[index].name.indexOf(" ") + 2)),
            ),
            trailing: IconButton(
                iconSize: 30,
                color: Colors.red,
                icon: Icon(Icons.remove_circle_rounded),
                //async and await to properly utilize dialog box
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
                  //print(isRemove);
                  setState(() {});
                  widget.onPressedUpdate(widget.checkoutDishes);
                })),
      ),
    );
  }
}
