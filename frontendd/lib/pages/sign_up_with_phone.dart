import 'package:finance_chatbot/components/buttons.dart';
import 'package:finance_chatbot/components/textfield.dart';
import 'package:finance_chatbot/pages/homepage.dart';
import 'package:finance_chatbot/pages/loginpage.dart';
import 'package:finance_chatbot/pages/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpWithPhone extends StatefulWidget {
  SignUpWithPhone({super.key});

  @override
  State<SignUpWithPhone> createState() => SignUpWithPhoneState();
}

class SignUpWithPhoneState extends State<SignUpWithPhone> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String verificationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isChecked = false;

  void sendOTP() async{
    await auth.verifyPhoneNumber(phoneNumber: "+91${phoneController.text}", verificationCompleted: (PhoneAuthCredential credential) async{
      await auth.signInWithCredential(credential);
    }, verificationFailed: (FirebaseAuthException e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Verification failed: ${e.message}"),
          backgroundColor: Colors.red,
        ),
      );
    },codeSent: (String verificationId, int? resendToken) {
      setState(() {
        this.verificationId = verificationId;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("OTP sent successfully!"),
          backgroundColor: Colors.blue,
        ),
      );
    },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpController.text);
    try{
      await auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Phone Verification Succesful"), backgroundColor: Colors.green,));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()), // Change HomePage to your actual homepage widget
      );
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("OTP verification failed: $e"),
          backgroundColor: Colors.red,
        ),
      );
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => RegisterPage()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Sign Up with Phone",
          style: TextStyle(
            fontSize: 26 * textScale,
            fontWeight: FontWeight.bold,
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
                controller: phoneController,
                height: 62,
                text: "Enter your phone no",
              ),
              SizedBox(
                height: 15,
              ),

              Textfield(
                ObscureText: true,
                controller: otpController,
                height: 16,
                text: "Enter your OTP",
              ),
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
                    Expanded(
                      // Wraps text properly
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
                      minimumSize: const Size(0, 0),
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
                onTap: () {
                  sendOTP();
                },
                text: const Text(
                  "Send OTP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                color: const Color.fromARGB(255, 230, 160, 223),
                color1: const Color.fromARGB(255, 186, 125, 180),
                height: 56,
                width: MediaQuery.of(context).size.width * 0.9, // Responsive Width
              ),
              SizedBox(height: 10),
              Buttons(
                onTap: () {
                  verifyOTP();
                },
                text: const Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                color: const Color.fromARGB(255, 230, 160, 223),
                color1: const Color.fromARGB(255, 186, 125, 180),
                height: 56,
                width: MediaQuery.of(context).size.width * 0.9, // Responsive Width
              ),
            ],
          ),
        ),
      ),
    );
  }
}
