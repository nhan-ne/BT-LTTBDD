import 'package:bai_tap_tuan_2/staff_list.dart';
import 'package:flutter/material.dart';
import 'book_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Nhân viên", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height:10),
            StaffList(),

            SizedBox(height: 20),
            Text("Danh sách sách", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(child: BookList()),

            SizedBox(height: 20),
            //StatusBar(),
          ],
        )
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey, // Màu viền
              width: 2, // Độ dày viền
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "DS Sách"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Nhân viên"),
          ],
        ),
      ),
    );
  }
}
