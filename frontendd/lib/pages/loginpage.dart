import 'package:finance_chatbot/pages/sign_up_with_phone.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finance_chatbot/components/buttons.dart';
import 'package:finance_chatbot/components/sign_in_button.dart';
import 'package:finance_chatbot/components/textfield.dart';
import 'package:finance_chatbot/pages/forgot_password.dart';
import 'package:finance_chatbot/pages/homepage.dart';
import 'package:finance_chatbot/pages/login_or_register.dart';
import 'package:finance_chatbot/pages/registerpage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> signInWithEmail() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pushReplacement(
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
        backgroundColor: Colors.redAccent,
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.10,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginOrRegister()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 26 * textScale,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),

            /// Email Input
            Textfield(
              ObscureText: false,
              controller: emailController,
              height: screenHeight * 0.06,
              text: "Enter your email",
            ),

            SizedBox(height: screenHeight * 0.01),

            /// Password Input
            Textfield(
              ObscureText: true,
              controller: passwordController,
              height: screenHeight * 0.0006,
              text: "Enter your password",
            ),

            /// Forgot Password Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()));
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 228, 99, 211),
                    fontSize: 16 * textScale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            /// Login Button
            Buttons(
              onTap: signInWithEmail,
              text: Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 * textScale),
              ),
              color: const Color.fromARGB(255, 230, 160, 223),
              color1: const Color.fromARGB(255, 186, 125, 180),
              height: screenHeight * 0.06,
              width: screenWidth * 0.9,
            ),

            SizedBox(height: screenHeight * 0.02),

            /// Register Option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 18 * textScale),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => RegisterPage()));
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
                      fontSize: 18 * textScale,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            /// OR Divider
            Row(
              children: [
                Expanded(child: Divider(thickness: 1.5, color: Colors.grey[300])),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: Text(
                    "OR",
                    style: TextStyle(fontSize: 16 * textScale, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: Divider(thickness: 1.5, color: Colors.grey[300])),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            /// Google Sign-in
            SignInButton(
              onTap: () {},
              text: "Sign in with Google",
              height: screenHeight * 0.06,
              width: screenWidth * 0.9,
              imagepath: 'lib/images/google.png',
            ),

            SizedBox(height: screenHeight * 0.01),

            /// Apple Sign-in
            SignInButton(
              onTap: () {},
              text: "Sign in with Apple",
              height: screenHeight * 0.06,
              width: screenWidth * 0.9,
              imagepath: 'lib/images/Apple.png',
            ),

            SizedBox(height: screenHeight * 0.01),

            /// Phone Number Sign-in
            SignInButton(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpWithPhone()));
              },
              text: "Sign in with Phone No",
              height: screenHeight * 0.06,
              width: screenWidth * 0.9,
              imagepath: 'lib/images/phone.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

