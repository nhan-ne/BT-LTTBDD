import 'package:flutter/material.dart';
import 'list_lazy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Ẩn banner debug
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Nền trắng cho toàn bộ ứng dụng
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(widget.title),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 50,),

            Text('Navigation',
            style:TextStyle(
              fontSize: 16,
              fontWeight:FontWeight.bold, 
              )
            ),
            SizedBox(height: 15,),

            Text('is a framework that simplifies the implementation of navigation between different UI components (activities, fragments, or composables) in an app',
            textAlign: TextAlign.center,
            style:TextStyle(
              color: Color(0xff4A4646),
              fontSize: 14,                     
              )
            ),
            Spacer(),

            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color:Color(0xff2196F3),
                borderRadius:BorderRadius.circular(50)
              ),
              child: ElevatedButton(
                onPressed:(){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListViewScreen()),
                  );
                },
                style:ElevatedButton.styleFrom(
                  backgroundColor:Colors.transparent,
                  shadowColor: Colors.transparent,
                ),  
                child: Text('PUSH',
                style:TextStyle(fontSize: 20, color:Colors.white)
                )
              )
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
