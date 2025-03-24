import 'package:flutter/material.dart';
import 'detail.dart';


class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LazyColumn',
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold, 
            color: Colors.blue
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 1000000,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0x4d2196F3),
              borderRadius: BorderRadius.circular(8)
            ),
            child: ListTile(
              title: Text("${index + 1} | The only way to do great work is to love what you do"),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(index: index + 1)),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

