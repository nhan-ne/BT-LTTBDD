import 'package:flutter/material.dart';

void main() {
  runApp(AgeCheckApp());
}

class AgeCheckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgeCheckScreen(),
    );
  }
}

class AgeCheckScreen extends StatefulWidget {
  @override
  _AgeCheckScreenState createState() => _AgeCheckScreenState();
}

class _AgeCheckScreenState extends State<AgeCheckScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String result = "";

  void checkAgeCategory() {
    String name = nameController.text;
    int? age = int.tryParse(ageController.text);

    if (name.isEmpty || age == null) {
      setState(() {
        result = "Vui lòng nhập đầy đủ thông tin!";
      });
      return;
    }

    String category;
    if (age > 65) {
      category = "Người già";
    } else if (age >= 6 && age <= 65) {
      category = "Người lớn";
    } else if (age >= 2 && age < 6) {
      category = "Trẻ em";
    } else {
      category = "Em bé";
    }

    setState(() {
      result = "$name là: $category";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("THỰC HÀNH 01"),
        //backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Họ và tên",
                border: OutlineInputBorder(), // Thêm viền cho ô nhập
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tuổi",
                border: OutlineInputBorder(), // Thêm viền cho ô nhập
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkAgeCategory,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bo góc nút
                ),
                backgroundColor: Colors.blue, // Màu nền nút
              ),
              child: Text(
                "Kiểm tra",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(
              result,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
