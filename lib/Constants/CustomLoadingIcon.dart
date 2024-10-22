import 'package:flutter/material.dart';

class CustomLoadingIcon extends StatefulWidget {
  const CustomLoadingIcon({super.key});

  @override
  _CustomLoadingIconState createState() => _CustomLoadingIconState();
}

class _CustomLoadingIconState extends State<CustomLoadingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(); // Repeat animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset(
        'Assets/Images/appicon.png', // Path to your app icon
        width: 50, // Adjust size accordingly
        height: 50,
      ),
    );
  }
}
