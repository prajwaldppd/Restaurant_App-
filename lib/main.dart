import 'package:coffee/datamanager.dart';
import 'package:coffee/pages/Navpage.dart';
import 'package:coffee/pages/login_page.dart';
import 'package:coffee/pages/main_page.dart';
import 'package:coffee/pages/offers_page.dart';
import 'package:coffee/pages/order_page.dart';
import 'package:coffee/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  bool _authenticated = false;
  UserData? _userData;

  bool get isAuthenticated => _authenticated;
  UserData? get userData => _userData;

  void setAuthenticated(bool value) {
    _authenticated = value;
    notifyListeners();
  }

  void setUserData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Masters',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const AuthChecker(),
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || !snapshot.data!) {
          // Not logged in, navigate to login page
          return Scaffold(
            body: LoginPage(),
          );
        } else {
          // User is logged in, navigate to home page
          return const MyHomePage(title: 'Flutter Demo Home Page');
        }
      },
    );
  }

  Future<bool> checkLoginStatus(BuildContext context) async {
    // Use context.read to access the AuthProvider
    final bool isAuthenticated = context.read<AuthProvider>().isAuthenticated;

    // Return the authentication status
    return isAuthenticated;
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
  // Add your DataManager class here
  var dataManager = DataManager();
  late Widget currentWidgetPage;

  @override
  void initState() {
    super.initState();
    // Set the initial page based on the selectedIndex
    setCurrentWidgetPage();
  }

  void setCurrentWidgetPage() {
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
  }

  @override
  Widget build(BuildContext context) {
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
            setCurrentWidgetPage();
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
