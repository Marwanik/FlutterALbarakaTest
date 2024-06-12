import 'package:albarakaquizapp/HomeScreen.dart';
import 'package:albarakaquizapp/config/get_it_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Printscreen extends StatelessWidget {
  const Printscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome  ${core.get<SharedPreferences>().getString('name') ?? 'User'}"),
            SizedBox(height: 50,),
            Text("Welcome  ${core.get<SharedPreferences>().getString('pass') ?? 'User'}"),

          ],
        ),
      ),
      appBar: AppBar(actions: [IconButton(onPressed: (){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      }, icon: Icon(Icons.home))],),
    );
  }
}
