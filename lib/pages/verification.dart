import 'package:finance_chatbot/components/buttons.dart';
import 'package:finance_chatbot/pages/forgot_password.dart';
import 'package:finance_chatbot/pages/homepage.dart';
import 'package:finance_chatbot/pages/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Verification extends StatefulWidget {
  final String selectedMethod;
  final String? verificationId; // For phone verification

  Verification({required this.selectedMethod, this.verificationId});

  @override
  VerificationState createState() => VerificationState();
}

class VerificationState extends State<Verification> {
  final List<TextEditingController> _controllers =
  List.generate(6, (index) => TextEditingController());

  void verifyByPhone() async {
    String enteredOtp = _controllers.map((c) => c.text).join(); // Get OTP input

    if (widget.selectedMethod == "phone" && widget.verificationId != null) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId!,
          smsCode: enteredOtp,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Homepage(),
          ),
        );
      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid OTP. Please try again.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.12,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ForgotPassword()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Text(
                "Forgot Your Password?",
                style: TextStyle(
                  fontSize: screenWidth * 0.09,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Text(
                widget.selectedMethod == "email"
                    ? "Check confirmation code sent on email."
                    : "Check confirmation code sent on phone.",
                style: TextStyle(fontSize: screenWidth * 0.045),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: screenWidth * 0.12,
                  child: TextField(
                    controller: _controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: screenHeight * 0.06),
            Buttons(
              onTap: verifyByPhone, // Calls the function to verify OTP first
              text: Text(
                "Verify",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              color: const Color.fromARGB(255, 225, 149, 216),
              color1: const Color.fromARGB(255, 213, 142, 205),
              height: screenHeight * 0.07,
              width: screenWidth * 0.85,
            ),

            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn’t receive code?"),
                TextButton(
                  onPressed: () {
                    // TODO: Implement resend functionality
                  },
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 232, 129, 250)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



