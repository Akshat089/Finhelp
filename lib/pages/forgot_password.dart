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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            icon: const Icon(Icons.arrow_back),
          )),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "Forgot Your Password?",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SizedBox(
                  width: 680,
                ),
                Text(
                  "Enter your email or your phone number we will send a confirmation code",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            CustomToggleButton(
              onToggle: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              initialIndex: _selectedIndex,
            ),

            const SizedBox(height: 40),

            // Input Field
            // Input Field with reduced width
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.55, // Adjust width as needed
              child: TextField(
                decoration: InputDecoration(
                  labelText: _selectedIndex == 0
                      ? "Enter Email"
                      : "Enter Phone Number",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Adjust for rounded corners
                    borderSide: BorderSide(color: Colors.grey), // Border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Colors.grey), // Normal state border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 214, 115, 206),
                        width: 2), // Highlight when focused
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 14, horizontal: 16), // Padding inside
                ),
                keyboardType: _selectedIndex == 0
                    ? TextInputType.emailAddress
                    : TextInputType.phone,
              ),
            ),

            const SizedBox(height: 40),
            Buttons(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Verification(
                        selectedMethod: _selectedIndex == 0 ? "email" : "phone",
                      ),
                    ),
                  );
                },
                text: Text(
                  "Reset Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                color: const Color.fromARGB(255, 225, 149, 216),
                color1: const Color.fromARGB(255, 213, 142, 205),
                height: 56,
                width: 327)
          ],
        ),
      ),
    );
  }
}
