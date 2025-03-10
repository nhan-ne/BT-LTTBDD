import 'package:flutter/material.dart';

class StaffList extends StatefulWidget {
  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  List<String> staff = ["Nguyễn Duy Khương", "Trần Thị Cẩm Ly", "Lê Thị Kim Phụng", "Trần Ngọc Nhẫn"]; 
  String? selectedStaff; // Giá trị mặc định

  @override
  Widget build(BuildContext context) {
    return Row (
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: DropdownButtonHideUnderline(
            child:DropdownButton<String>(
              hint: Text("Chọn sinh viên"),
              value: selectedStaff,
              onChanged: (String? newValue) {
                setState(() {
                  selectedStaff = newValue!;
                });
              },
              items: staff.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()
            )
          )
        ),
        SizedBox(width: 10),
        Container (
          height: 50,
          decoration:BoxDecoration(
            color:Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // Giữ nền theo Container
              shadowColor: Colors.transparent, // Xóa bóng gốc của button
            ),
            child: Text("Đổi",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              )
            )
          ),
        )
      ]
    );
  }
}
