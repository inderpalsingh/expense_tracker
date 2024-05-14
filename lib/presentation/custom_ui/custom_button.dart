import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Widget? mWidget;
  final VoidCallback onTap;

  CustomButton({
    required this.name,
    required this.onTap,
    this.mWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: mWidget ?? Text(name),
        ),
      ),
    );
  }
}
