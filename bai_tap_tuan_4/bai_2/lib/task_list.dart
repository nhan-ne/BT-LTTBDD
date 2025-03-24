import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'task_detail.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<dynamic> _tasks = []; 
  bool _isLoading = true; 
  String _errorMessage = ""; 

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse('https://amock.io/api/researchUTH/tasks'));

      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData is List) {
          setState(() {
            _tasks = responseData;
            _isLoading = false;
          });
        } else if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
          setState(() {
            _tasks = responseData['data']; // Lấy danh sách từ key 'data'
            _isLoading = false;
          });
        } else {
          throw Exception('Dữ liệu API không hợp lệ');
        }
      } else {
        throw Exception('Lỗi API: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, 
        title: Row(
          children: [
            Image.asset('assets/images/logo_uth.png', height: 50),  
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SmartTasks",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "A simple and efficient to-do app",
                  style: TextStyle(
                    color: Color(0xff3991D8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.blue),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child:
         _isLoading
          ? const Center(child: CircularProgressIndicator()) 
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red)))
          : _tasks.isEmpty
          ? _buildEmptyScreen() 
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final List<Color> colors = [
                  Color(0x4f2196F3), // Xanh dương nhạt
                  Color(0xffE1BBC1), // Hồng nhạt
                  Color(0xffC1E1C1), // Xanh lá nhạt
                ];
                return Container(
                  height: 120,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: colors[index % 3],// Màu xen kẽ
                    borderRadius:BorderRadius.circular(16) 
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Text(_tasks[index]['title']),
                        subtitle: Text(_tasks[index]['description']),
                        trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailScreen(task: _tasks[index]),
                            ),
                          );
                        },
                      ),

                    ],
                  )
                );
                
              },
        ),
      )
    );
  }
}

Widget _buildEmptyScreen() {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              children: [
                Image.asset('assets/images/empty.png'),
                SizedBox(height: 20,),
                Text('No Tasks Yet!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                Text('Stay productive—add something to do',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff333333)
                  ),
                )
              ],
            ),
          )
        ],
      )
  );
}
