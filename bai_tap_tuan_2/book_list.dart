import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<String> books = ["Sách 1", "Sách 2", "Sách 3"];
  List<bool> selectedBooks = [false, false, false]; // Trạng thái checkbox

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: 220, // Giới hạn chiều cao của danh sách sách
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),

          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),

                child: ListTile(
                  leading: Checkbox(
                    value: selectedBooks[index],
                    activeColor: Colors.red, // Màu đỏ khi được chọn
                    onChanged: (bool? value) {
                      setState(() {
                        selectedBooks[index] = value!;
                      });
                    },
                  ),
                  title: Text(books[index]),
                )
              );
            },
          ),
        ),
        Spacer(),

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
            child: Text("Thêm",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              )
            )
          ),
        )
      ],
    );
  }
}
