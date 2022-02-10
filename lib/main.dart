import 'dart:math';

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

      // This trailing comma makes auto-formatting nicer for build methods.
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
          subtitle: Text(
              dishes[index].description + " " + dishes[index].price.toString()),
          leading: CircleAvatar(
            child: Text(dishes[index].name.substring(0, 1)),
            //to give random colors to circle avatar
            backgroundColor:
                Colors.primaries[_random.nextInt(Colors.primaries.length)]
                    [_random.nextInt(9) * 100],
          ),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {},
        ),
      ),
    );
  }
}
