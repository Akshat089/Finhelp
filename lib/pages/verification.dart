import 'package:finance_chatbot/components/buttons.dart';
import 'package:finance_chatbot/pages/forgot_password.dart';
import 'package:finance_chatbot/pages/reset_password.dart';
import 'package:flutter/material.dart';

class Verification extends StatefulWidget {
  final String selectedMethod; // "email" or "phone"
  Verification({required this.selectedMethod});

  @override
  VerificationState createState() => VerificationState();
}

class VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
            },
            icon: const Icon(Icons.arrow_back),
          )),
      body: Container(
          child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          "Forgot Your Password?",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            SizedBox(
              width: 680,
            ),
            Center(
              child: Text(
                widget.selectedMethod == "email"
                    ? "                        Check confirmation code sent on email."
                    : "                        Check confirmation code sent on phone.",
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 250,
        ), //this is for verification implementation later when we add firebasing
        Buttons(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ResetPassword(selectedMethod: widget.selectedMethod),
              ),
            );
          },
          text: Text(
            "Verify",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          color: const Color.fromARGB(255, 225, 149, 216),
          color1: const Color.fromARGB(255, 213, 142, 205),
          height: 56,
          width: 327,
        ),

        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Didn’t receive code?"),
            TextButton(
              onPressed: () {
                // TODO: Implement resend functionality later
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
      ])),
    );
  }
}
