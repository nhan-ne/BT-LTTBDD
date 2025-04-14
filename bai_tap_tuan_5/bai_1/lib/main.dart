import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Login',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
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
    } catch (e) {
      setState(() {
        _errorMessage = "$e";
        _user = null;
      });
    }
  }

  // Đăng xuất
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
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ElevatedButton(
                  onPressed: signInWithGoogle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text('Login by Gmail',
                    style:TextStyle(
                      fontSize:20,
                      color: Colors.white
                    )
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Hiển thị thông báo lỗi nếu có
              if (_errorMessage != null)
                _buildMessage(Colors.red, "Google Sign-In Failed", _errorMessage!),

              // Hiển thị thông báo thành công nếu đăng nhập thành công
              if (_user != null)                  
                _buildMessage(Colors.green, "Success!", " Hi ${_user!.email} Welcome to UTHSmartTasks"),
              SizedBox(height: 20,),

              if (_user != null)
                ElevatedButton(
                  onPressed: signOut,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ), 
            ],
          ),
        ),
      ),
    );
  }
}
// Hàm tái sử dụng hiển thị thông báo
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
