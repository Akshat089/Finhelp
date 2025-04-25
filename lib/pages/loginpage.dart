import 'package:finance_chatbot/components/buttons.dart';
import 'package:finance_chatbot/components/sign_in_button.dart';
import 'package:finance_chatbot/components/textfield.dart';
import 'package:finance_chatbot/pages/forgot_password.dart';
import 'package:finance_chatbot/pages/homepage.dart';
import 'package:finance_chatbot/pages/login_or_register.dart';
import 'package:finance_chatbot/pages/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email_controller = TextEditingController();
  bool isLoading = false;
  final TextEditingController password_controller = TextEditingController();

  

  Future<void> signInWithEmail() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_controller.text, password: password_controller.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "User Not Found";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect Password";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid Email Format";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: const Color.fromARGB(255, 238, 103, 93),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginOrRegister()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0), // Moves title lower
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Center(
              child: Textfield(
                  ObscureText: false,
                  controller: email_controller,
                  height: 62,
                  text: "Enter your email"),
            ),
            Center(
              child: Textfield(
                  ObscureText: true,
                  controller: password_controller,
                  height: 16,
                  text: "Enter your password"),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 1100,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Removes extra padding
                      minimumSize:
                          Size(0, 0), // Ensures no extra space around text
                      tapTargetSize:
                          MaterialTapTargetSize.shrinkWrap, // Shrinks tap area
                    ),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 228, 99, 211),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Buttons(
                onTap: () {
                  signInWithEmail();
                },
                text: Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                color: const Color.fromARGB(255, 230, 160, 223),
                color1: const Color.fromARGB(255, 186, 125, 180),
                height: 56,
                width: 427),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 820,
                  ),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color.fromARGB(255, 228, 99, 211),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1.5,
                    color: Colors
                        .grey[300], // Light grey color for a subtle effect
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.grey[600], // Slightly darker grey for contrast
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1.5,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SignInButton(
                onTap: () {},
                text: "Sign in with Google",
                height: 56,
                width: 427,
                imagepath: 'lib/images/google.png'),
            SizedBox(
              height: 10,
            ),
            SignInButton(
                onTap: () {},
                text: "Sign in with Apple",
                height: 56,
                width: 427,
                imagepath: 'lib/images/Apple.png'),
            SizedBox(
              height: 10,
            ),
            SignInButton(
                onTap: () {},
                text: "Sign in with Phone No",
                height: 56,
                width: 427,
                imagepath: 'lib/images/phone.jpg')
          ],
        ),
      ),
    );
  }
}
