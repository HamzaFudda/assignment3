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
      home: const MyHomePage(title: 'Dish'),
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
  List<dish> dishes = [
    dish(name: "Chicken Burger", description: "Classic burger", price: 300.0),
    dish(
        name: "Chicken Cheese Burger",
        description: "Classic Cheese burger",
        price: 340.0),
    dish(name: "Crispy Burger", description: "Classic burger", price: 400.0),
    dish(name: "Jumbo Burger", description: "Classic burger", price: 500.0),
  ];
  List<dish> cart_dishes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text("List", style: new TextStyle(fontSize: 28)),
          SizedBox(
            height: 40,
          ),
          Expanded(child: _listBuilder(context)),
        ],
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => checkout(checkoutDishes: cart_dishes,
                    onPressedUpdate: (changed){
                      cart_dishes=changed;
                      setState(() {
                      });
                    }),
              ),
            );
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        )
    );
  }

  ListView _listBuilder(context) {
    final _random = Random();
    return ListView.builder(
      itemCount: dishes.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: ListTile(
            title: Row(children: [
              Text(dishes[index].name),
            ]),
            subtitle: Text(dishes[index].description +
                " " +
                dishes[index].price.toString()),
            leading: CircleAvatar(
              child: Text(dishes[index].name.substring(0, 1)),

            ),
            trailing: IconButton(
                iconSize: 30,
                color: cart_dishes.contains(dishes[index]) ? Colors.red : Colors.green,
                icon: cart_dishes.contains(dishes[index])
                    ? Icon(Icons.remove_circle_rounded)
                    : Icon(Icons.add_circle_rounded),
                onPressed: () {
                  setState(() {
                        cart_dishes.contains(dishes[index])
                        ?cart_dishes.remove(dishes[index])
                            :cart_dishes.add(dishes[index]);
                  });
                }
                )
        ),
      ),
    );
  }
}
