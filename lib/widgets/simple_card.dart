import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  final Widget child;
  SimpleCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(padding: EdgeInsets.all(12), child: child),
    );
  }
}