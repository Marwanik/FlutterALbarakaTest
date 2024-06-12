import 'package:albarakaquizapp/PrintScreen.dart';
import 'package:albarakaquizapp/config/get_it_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  LoginScreen({super.key});@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B2F6C),
      body: Center(
        child: SingleChildScrollView(
          child: Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(

                  alignment: Alignment.center,
                  children: [

                    CircleAvatar(
                      backgroundColor: Color(0xffFFF8C9),
                      radius: 75,
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xff77C1C1),
                      radius: 60,
                      backgroundImage: AssetImage("assets/Intersect.png"),
                    ),
                  ],
                ),

                Container(
                  height: 300,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Email"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Example@gmail.com",
                          filled: true,
                          fillColor: Color(0xff77C1C1).withOpacity(0.75),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text("Password"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          bool obscureText = true;
                          return TextField(
                            controller: password,
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              hintText: "*******",
                              filled: true,
                              fillColor: Color(0xff77C1C1).withOpacity(0.75),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          bool isChecked = false;
                          return Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                                child: Text('Remember me'),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      core.get<SharedPreferences>().setString('name', name.text);

                      core
                          .get<SharedPreferences>()
                          .setString('pass', password.text);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Printscreen(),
                          ));

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFEACD),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Login'),
                  ),
                ),
                SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Color(0xffFFFFFF)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Color(0xffA3F9F9)),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
