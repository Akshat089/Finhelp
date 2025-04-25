import 'package:finance_chatbot/components/drawer.dart';
import 'package:finance_chatbot/pages/chat_bot_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScale = MediaQuery.of(context).textScaleFactor;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.10,
        title: Text(
          "Hey There",
          style: TextStyle(
            fontSize: 26 * textScale,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: DrawerMenu(screenHeight: screenHeight),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight*0.1,),
              Container(
                width: screenWidth * 0.8, // Restrict width to 60% of screen width
                padding: EdgeInsets.all(8), // Padding around the tile
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  border: Border.all(color: Colors.black, width: 2), // Black border
                ),
                child: ListTile(
                  title: Center( // Center the text inside ListTile
                    child: Text(
                      "Interact With Betalabot for financial queries",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatBotPage()));
                  },
                ),
              ),
              SizedBox(height: screenHeight*0.05,),
              Container(
                width: screenWidth * 0.8, // Restrict width to 60% of screen width
                padding: EdgeInsets.all(8), // Padding around the tile
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  border: Border.all(color: Colors.black, width: 2), // Black border
                ),
                child: ListTile(
                  title: Center( // Center the text inside ListTile
                    child: Text(
                      "Check out stock options here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onTap: (){},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
