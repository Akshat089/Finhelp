import 'package:finance_chatbot/components/buttons.dart';
import 'package:finance_chatbot/pages/loginpage.dart';
import 'package:finance_chatbot/pages/registerpage.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 212, 115, 229),
      ),
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 225, 194, 220),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: 50,
              ),
              SizedBox(
                width: 311,
                height: 226,
                child: Image.asset(
                  'lib/images/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Login or register to get answers to all your finance related questions",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 128,
                width: 263,
                child: Column(
                  children: [
                    Buttons(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      text: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none, // Remove underline
                        ),
                      ),
                      color: const Color.fromARGB(255, 222, 140, 220),
                      color1: const Color.fromARGB(255, 214, 122, 228),
                      height: 55,
                      width: 263,
                    ),
                    SizedBox(height: 18),
                    Buttons(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      text: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 222, 140, 220),
                          decoration: TextDecoration.none, // Remove underline
                        ),
                      ),
                      color: Colors.white,
                      color1: const Color.fromARGB(255, 214, 122, 228),
                      height: 55,
                      width: 263,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
