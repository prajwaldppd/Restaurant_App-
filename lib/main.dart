import 'package:coffee/datamanager.dart';
import 'package:coffee/pages/Navpage.dart';
import 'package:coffee/pages/main_page.dart';
import 'package:coffee/pages/offers_page.dart';
import 'package:coffee/pages/order_page.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Masters',
      navigatorKey: navigatorKey, // Set the navigatorKey
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  var selectedIndex = 0;
  var dataManager = DataManager();
  Widget currentWidgetPage = const Text("Menu");

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        currentWidgetPage = MenuPage(
          dataManager: dataManager,
        );
        break;
      case 1:
        currentWidgetPage = const offerspage();
        break;
      case 2:
        currentWidgetPage = OrderPage(
          dataManager: dataManager,
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee App'),
      ),
      drawer: NavBar(),
      body: currentWidgetPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.amber.shade300,
        unselectedItemColor: Colors.amber.shade50,
        items: const [
          BottomNavigationBarItem(label: "Menu", icon: Icon(Icons.coffee)),
          BottomNavigationBarItem(
              label: "Offers", icon: Icon(Icons.local_offer)),
          BottomNavigationBarItem(
              label: "Order", icon: Icon(Icons.shopping_cart_checkout_outlined))
        ],
      ),
    );
  }
}
