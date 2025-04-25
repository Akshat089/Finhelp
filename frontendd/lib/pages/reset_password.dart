import 'package:finance_chatbot/components/buttons.dart';
import 'package:finance_chatbot/components/textfield.dart';
import 'package:finance_chatbot/pages/verification.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  final String
      selectedMethod; // To store whether "email" or "phone" was selected

  ResetPassword({super.key, required this.selectedMethod});
  final TextEditingController password_controller = TextEditingController();
  final TextEditingController confirm_password_controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Verification(selectedMethod: selectedMethod),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 24.0), // Adds padding for better alignment
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Aligns text to center
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Create New Password",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Create Your New Password to login",
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.center, // Ensures proper alignment
              ),
            ),
            const SizedBox(height: 50),
            Textfield(
                ObscureText: true,
                controller: password_controller,
                height: 56,
                text: "Enter New Password"),
            SizedBox(height: 10,),
            Textfield(ObscureText: true, controller: confirm_password_controller, height: 16, text: "Confirm Password"),
            SizedBox(height: 30,),
            Buttons(onTap: (){}, text: Text(
                  "Confirm Password",
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
