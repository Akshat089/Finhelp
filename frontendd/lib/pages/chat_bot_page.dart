import 'package:finance_chatbot/components/drawer.dart';
import 'package:flutter/material.dart';

class ChatBotPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BetaBot 7.0'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Left drawer
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Scaffold.of(context).openEndDrawer(); // Right drawer
            },
          ),
        ],
      ),

      // 🧭 Left Drawer
      drawer: DrawerMenu(screenHeight: screenHeight),

      // 📜 Right Drawer
      endDrawer: Drawer(
        child: Column(
          children: const [
            DrawerHeader(
              child: Text('Chat History', style: TextStyle(fontSize: 20)),
            ),
            Expanded(
              child: Center(child: Text("Coming soon...")),
            ),
          ],
        ),
      ),

      // 💬 Main Body
      body: Column(
        children: [
          Expanded(child: Container()), // Empty for now

          // 🧠 Input + Buttons
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Ask BetaBot...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16), // You can adjust the radius value
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Web Search',
                  onPressed: () {
                    // Web search logic
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.public),
                  tooltip: 'Gov Site Search',
                  onPressed: () {
                    // Gov site search logic
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.image),
                  tooltip: 'Upload Image',
                  onPressed: () {
                    // Image upload logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
