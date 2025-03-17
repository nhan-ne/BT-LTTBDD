import 'package:flutter/material.dart';

class ComponentDetail extends StatelessWidget {
  final String title;
  final Widget content;

  ComponentDetail({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('$title Detail',
        style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: content),
      ),
    );
  }
}
