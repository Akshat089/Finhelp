import 'package:finance_chatbot/pages/loginpage.dart';
import 'package:finance_chatbot/pages/sign_up_with_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finance_chatbot/components/buttons.dart';
import 'package:finance_chatbot/components/sign_in_button.dart';
import 'package:finance_chatbot/components/textfield.dart';
import 'package:finance_chatbot/pages/login_or_register.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isChecked = false;

  Future<void> signUpWithEmail() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Navigate to the login page after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginOrRegister()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 20.0), // Moves title lower
          child: Text(
            "Sign Up",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Textfield(
                ObscureText: false,
                controller: emailController,
                height: 62,
                text: "Enter your email",
              ),
              Textfield(
                ObscureText: true,
                controller: passwordController,
                height: 16,
                text: "Enter your password",
              ),
              Textfield(
                ObscureText: true,
                controller: confirmPasswordController,
                height: 16,
                text: "Confirm Your Password",
              ),
              const SizedBox(height: 10),

              // Checkbox and Terms of Service Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isChecked = newValue!;
                        });
                      },
                    ),
                    Expanded( // Wraps text properly
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          const Text("I agree to the findoc "),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Terms of Service",
                              style: TextStyle(
                                color: Color.fromARGB(255, 223, 120, 207),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(" and "),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Privacy Policy",
                              style: TextStyle(
                                color: Color.fromARGB(255, 223, 120, 207),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a member?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color.fromARGB(255, 228, 99, 211),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              Buttons(
                onTap: signUpWithEmail,
                text: const Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                color: const Color.fromARGB(255, 230, 160, 223),
                color1: const Color.fromARGB(255, 186, 125, 180),
                height: 56,
                width: MediaQuery.of(context).size.width * 0.9, // Responsive Width
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey[300],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
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

              const SizedBox(height: 20),
              SignInButton(
                onTap: () {},
                text: "Sign up with Google",
                height: 56,
                width: MediaQuery.of(context).size.width * 0.9,
                imagepath: 'lib/images/google.png',
              ),
              const SizedBox(height: 10),
              SignInButton(
                onTap: () {},
                text: "Sign up with Apple",
                height: 56,
                width: MediaQuery.of(context).size.width * 0.9,
                imagepath: 'lib/images/Apple.png',
              ),
              const SizedBox(height: 10),
              SignInButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpWithPhone()));
                },
                text: "Sign up with Phone No",
                height: 56,
                width: MediaQuery.of(context).size.width * 0.9,
                imagepath: 'lib/images/phone.jpg',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
