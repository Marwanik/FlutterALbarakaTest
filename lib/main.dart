import 'package:albarakaquizapp/HomeScreen.dart';
import 'package:albarakaquizapp/config/get_it_config.dart';
import 'package:albarakaquizapp/loginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  setup();
  runApp(const MyApp());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await configureDependencies(); // Call before runApp
//   runApp(const MyApp());
//   await clearSharedPreferences();
// }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
    );
  }
}
