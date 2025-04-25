import 'package:firebase_auth/firebase_auth.dart';
import 'package:finance_chatbot/components/buttons.dart';
import 'package:finance_chatbot/components/toggle_button.dart';
import 'package:finance_chatbot/pages/loginpage.dart';
import 'package:finance_chatbot/pages/verification.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  int _selectedIndex = 0;
  final TextEditingController _inputController = TextEditingController();
  bool _isLoading = false;

  void resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_selectedIndex == 0) {
        // Email Reset
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _inputController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Reset link sent to email!")),
        );
      } else {
        // Phone OTP Verification
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: _inputController.text.trim(),
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${e.message}")),
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Verification(
                  selectedMethod: "phone",
                  verificationId: verificationId,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed! Try again.")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1, vertical: 20), // Responsive Padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Forgot Your Password?",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Text(
                  "Enter your email or phone number. We will send a confirmation code.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              CustomToggleButton(
                onToggle: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                initialIndex: _selectedIndex,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: screenWidth * 0.7, // Responsive width
                child: TextField(
                  controller: _inputController,
                  decoration: InputDecoration(
                    labelText: _selectedIndex == 0
                        ? "Enter Email"
                        : "Enter Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                      BorderSide(color: Color.fromARGB(255, 214, 115, 206)),
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  ),
                  keyboardType: _selectedIndex == 0
                      ? TextInputType.emailAddress
                      : TextInputType.phone,
                ),
              ),
              const SizedBox(height: 30),
              Buttons(
                onTap: _isLoading ? null : resetPassword,
                text: Text(
                  "Reset Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                color: Color.fromARGB(255, 225, 149, 216),
                color1: Color.fromARGB(255, 213, 142, 205),
                height: 56,
                width: screenWidth * 0.5, // Responsive button width
              ),
            ],
          ),
        ),
      ),
    );
  }
}
