import 'package:flutter/material.dart';

class SimpleThemeSwitcher extends StatefulWidget {
  @override
  _SimpleThemeSwitcherState createState() => _SimpleThemeSwitcherState();
}

class _SimpleThemeSwitcherState extends State<SimpleThemeSwitcher> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isDarkMode,
      onChanged: (value) {
        setState(() {
          _isDarkMode = value;
        });
        // Show message (in real app, you'd change the actual theme)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value ? 'Dark Mode Enabled' : 'Light Mode Enabled'),
            duration: Duration(seconds: 1),
          ),
        );
      },
    );
  }
}