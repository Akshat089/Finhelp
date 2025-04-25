import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final Function(int) onToggle; // Callback to send selected index
  final int initialIndex;

  const CustomToggleButton({Key? key, required this.onToggle, this.initialIndex = 0}) : super(key: key);

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Initialize from the parent widget
  }

  void _toggle(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onToggle(index); // Send index to the parent
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton("Email", 0),
          _buildToggleButton("Phone", 1),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, int index) {
    return GestureDetector(
      onTap: () => _toggle(index),
      child: Container(
        
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.white : Colors.grey[200],
          borderRadius: BorderRadius.horizontal(
            left: index == 0 ? const Radius.circular(30) : Radius.zero,
            right: index == 1 ? const Radius.circular(30) : Radius.zero,
          ),
          boxShadow: _selectedIndex == index
              ? [BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1)]
              : [],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: _selectedIndex == index ? const Color.fromARGB(255, 223, 129, 203) : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
