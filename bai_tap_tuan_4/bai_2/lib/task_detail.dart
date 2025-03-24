import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final dynamic task;
  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text("Detail",
          style: TextStyle(
            color: Colors.blue
          ),
        )
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${task['title']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("${task['description']}", style: TextStyle(fontSize: 16)),

            SizedBox(height: 20),
            Text("Subtasks:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            task['subtasks'] != null && task['subtasks'].isNotEmpty
                ? Column(
                    children: task['subtasks'].map<Widget>((subtask) {
                      return ListTile(
                        leading: Icon(
                          subtask['isCompleted'] ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: subtask['isCompleted'] ? Colors.green : Colors.grey,
                        ),
                        title: Text(subtask['title']),
                      );
                    }).toList(),
                  )
                : Text("No subtasks available"),

            SizedBox(height: 20),
            Text("Attachments:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            task['attachments'] != null && task['attachments'].isNotEmpty
                ? Column(
                    children: task['attachments'].map<Widget>((attachment) {
                      return ListTile(
                        leading: Icon(Icons.attach_file, color: Colors.blue),
                        title: Text(attachment['fileName']),
                        subtitle: Text(attachment['fileUrl']),
                        onTap: () {
                          // Mở link file
                          print("Open URL: ${attachment['fileUrl']}");
                        },
                      );
                    }).toList(),
                  )
                : Text("No attachments available"),
          ],
        ),
      ),
    );
  }
}
