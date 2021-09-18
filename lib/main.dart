import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eunbeyol/constants.dart';
import 'package:eunbeyol/models/NavItem.dart';
import 'package:eunbeyol/screens/home/home_screen.dart';
import 'package:eunbeyol/screens/articles/routes.dart';
import 'package:eunbeyol/screens/articles/data.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavItems(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recipe App',
        theme: ThemeData(
          // backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          KoreanFoodScreen.routeName: (context) => KoreanFoodScreen(),
          AmericanFoodScreen.routeName: (context) => AmericanFoodScreen(),
          JapaneseFoodScreen.routeName: (context) => JapaneseFoodScreen(),
          ChineseFoodScreen.routeName: (context) => ChineseFoodScreen(),
        },
        home: HomeScreen(),
      ),
    );
  }
}
