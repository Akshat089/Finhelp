import 'package:finance_chatbot/components/buttons.dart';
import 'package:finance_chatbot/pages/loginpage.dart';
import 'package:finance_chatbot/pages/registerpage.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.12,
        backgroundColor: const Color.fromARGB(255, 212, 115, 229),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 1.0,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          color: const Color.fromARGB(255, 225, 194, 220),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),
              SizedBox(
                width: screenWidth * 0.7,
                height: screenHeight * 0.3,
                child: Image.asset(
                  'lib/images/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.06),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: Text(
                  "Login or register to get answers to all your finance related questions",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: screenWidth * 0.045),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              SizedBox(
                width: screenWidth * 0.8,
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
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      color: const Color.fromARGB(255, 222, 140, 220),
                      color1: const Color.fromARGB(255, 214, 122, 228),
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.8,
                    ),
                    SizedBox(height: screenHeight * 0.025),
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
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 222, 140, 220),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      color: Colors.white,
                      color1: const Color.fromARGB(255, 214, 122, 228),
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.8,
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
