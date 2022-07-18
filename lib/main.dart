import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_app/assistantMethods/cart_item_counter.dart';
import 'package:users_app/global/gloval.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
      ],
      child: MaterialApp(
        title: 'Riders App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        //initialRoute: '/auth',
        routes: {
          // '/auth': (context) => const AuthScren(),
          // '/login': (context) => const LoginScreen(),
          // '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
