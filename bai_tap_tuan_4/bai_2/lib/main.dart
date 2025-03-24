import 'package:flutter/material.dart';
import 'page_view.dart';
import 'package:google_fonts/google_fonts.dart';

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
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
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
  bool _isHovering = false;
  @override
  void initState() {
    super.initState();

    // Sau 3 giây tự động chuyển sang màn hình chính
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_uth.png', height:100, width:70),
            SizedBox(height: 20,),
            Text('UTH SmartsTasks',
              style:  GoogleFonts.righteous(fontSize:30,
                fontWeight:FontWeight.bold, 
                color:Color(0xff006EE9),
                decoration: _isHovering ? TextDecoration.underline : TextDecoration.none,
                decorationColor: Color(0xff006EE9), // Màu gạch chân
              )
            )
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
