
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'profile.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage ({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;
  String? _errorMessage;

  Future<void> signInWithGoogle() async {
  try {
    // Hiển thị hộp thoại đăng nhập Google
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      setState(() {
        _errorMessage = "User canceled the Google sign-in process.";
        _user = null;
      });
      return;
    }

    // Lấy thông tin xác thực từ tài khoản Google
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Đăng nhập vào Firebase
    UserCredential userCredential = await _auth.signInWithCredential(credential);
    setState(() {
      _user = userCredential.user;
      _errorMessage = null;
    });

    if (_user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(
            _user!.displayName ?? "No Name", 
            _user!.email ?? "No Email",
            _user!.photoURL ?? "",
          ),
        ),
      );
    }
  } catch (e) {
    setState(() {
      _errorMessage = "$e";
      _user = null;
    });
  }
}


  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    setState(() {
      _user = null;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(height: 10,),
              Text('SmartTasks',
                style:TextStyle(
                  fontSize:24,
                  fontWeight: FontWeight.w600,
                  color:Colors.blue
                ),
              ),
              Text('A simple and efficient to-do app',
                style:TextStyle(
                  fontSize: 12,
                  color: Colors.blue
                ),
              ),
              SizedBox(height: 100,),

              Text('Wellcome',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text('Ready to explore? Log in to get started.',
                style: TextStyle(
                  color: Color(0xff4A4646),
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 20,),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffD5EDFF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ElevatedButton.icon(
                  mainAxisAlignment: MainAxisAlignment: start,
                  icon: Image.asset('assets/images/google 2.png'),
                  label:Text('Sign in with Google',
                   style:TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                        )
                  ),
                  onPressed: signInWithGoogle,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    backgroundColor: Colors.transparent,
                    sh
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Hiển thị thông báo lỗi nếu có
              if (_errorMessage != null)
                _buildMessage(Colors.red, "Google Sign-In Failed", _errorMessage!)
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildMessage(Color color, String title, String message) {
  return Container(
    padding: EdgeInsets.all(20),
    width: double.infinity,
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
