import 'package:flutter/material.dart';
import 'component_detail.dart';
class ComponentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'UI Component List',
          style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView( // 🔹 Bọc nội dung trong SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Display'),
              _buildComponentButton(context, 'Text', 'Display text', Text('This is a Text widget')),
              _buildComponentButton(context, 'Image', 'Display an image', Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbWX8UtXu-pkmzO5d63if-cBRopNPQ0VwY7w&s')),


              _buildSectionTitle('Input'),
              _buildComponentButton(context, 'TextField', 'Input field for text', TextField(decoration: InputDecoration(labelText: "Enter text"))),
              _buildComponentButton(context, 'Passwords', 'Input field for passwords', TextField(obscureText: true, decoration: InputDecoration(labelText: "Enter password"))),

              _buildSectionTitle('Layout'),
              _buildComponentButton(context,'Column', 'Arranges elements vertically', Column(
                children: [Text('Item 1'), Text('Item 2')],
              )),
              _buildComponentButton(context, 'Row', 'Arranges elements horizontally', Row(
                children: [Text('Item 1'), SizedBox(width: 10), Text('Item 2')],
              )),

              SizedBox(height: 20), // Khoảng cách dưới cùng
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildComponentButton(BuildContext context, String title, String subtitle, Widget content ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 71,
        decoration: BoxDecoration(
          color: Color(0x4D2196F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComponentDetail(title: title, content: content),
            ),
          );
          },
          style: TextButton.styleFrom(
            alignment: Alignment.centerLeft,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
