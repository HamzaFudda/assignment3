import 'dart:math';
import 'package:assignment3/checkout.dart';
import 'package:assignment3/dishes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Dishes'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //list of dish to use as menu
  List<dish> dishes = [
    dish(name: "Chicken Burger", description: "Classic burger", price: 300.0),
    dish(
        name: "Chicken Cheese Burger",
        description: "Classic Cheese burger",
        price: 340.0),
    dish(name: "Crispy Burger", description: "Classic burger", price: 400.0),
    dish(name: "Jumbo Burger", description: "Classic burger", price: 500.0),
    dish(name: "Chicken Roll", description: "Roll", price: 200.0),
    dish(name: "Chicken Mayo Roll", description: "Mayo Roll", price: 220.0),
    dish(name: "Beef Roll", description: "Roll", price: 260.0),
    dish(name: "Beef Mayo Roll", description: "Mayo Roll", price: 280.0),
  ];

  //list of dish to handle cart
  List<dish> cart_dishes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              //Text to enhance UI
              Text("Menu", style: new TextStyle(fontSize: 28)),
              SizedBox(
                height: 40,
              ),
              Expanded(child: _listBuilder(context)),
              //To avoid last item getting shadowed by floating action button
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => checkout(
                    checkoutDishes: cart_dishes,
                    //use of callback
                    //changed is updated list which is passed through callback
                    onPressedUpdate: (changed) {
                      cart_dishes = changed;
                      setState(() {});
                    }),
              ),
            );
          },
          tooltip: 'Cart',
          //custom color
          backgroundColor: Colors.lightBlueAccent,
          child: Column(
            //mainaxissize to fully accumulate text with icon
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_shopping_cart_rounded),
              Text("Cart"),
            ],
          ),
        ));
  }

  //listview function to handle our menu
  ListView _listBuilder(context) {
    return ListView.builder(
      itemCount: dishes.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: ListTile(
            //tileColor: Colors.cyan,
            title: Row(children: [
              Text(dishes[index].name),
            ]),
            // description + price
            subtitle: Text(dishes[index].description +
                " " +
                dishes[index].price.toString()),
            leading: CircleAvatar(
              //dynamic picking of first letters of two words of the dish
              child: Text(dishes[index].name.substring(0, 1) +
                  "" +
                  dishes[index].name.substring(
                      dishes[index].name.indexOf(" ") + 1,
                      dishes[index].name.indexOf(" ") + 2)),
            ),
            trailing: IconButton(
                iconSize: 30,
                //checks if cart dish contains the item then color it as red else green
                color: cart_dishes.contains(dishes[index])
                    ? Colors.red
                    : Colors.green,
                //checks if cart dish contains the item then color it as - else +
                icon: cart_dishes.contains(dishes[index])
                    ? Icon(Icons.remove_circle_rounded)
                    : Icon(Icons.add_circle_rounded),
                onPressed: () {
                  //checks if cart dish contains the item then it removes it from the list on pressed else it adds to the list
                  cart_dishes.contains(dishes[index])
                      ? cart_dishes.remove(dishes[index])
                      : cart_dishes.add(dishes[index]);
                  setState(() {});
                })),
      ),
    );
  }
}
