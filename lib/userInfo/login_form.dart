import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:Scheduler/view/view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _authentication = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginFailedDlg(String error) {
    String message = '';

    switch(error) {
      case 'user-not-found':
        message = '사용자를 찾을 수 없습니다.';
        break;
      case 'wrong-password':
        message = '비밀번호가 올바르지 않습니다.';
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그인 실패'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('확인'),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: height * 0.23),
        child: Column(
          children: [
            Center(
              child: Text(
                '로그인',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 0.07 * height),
                width: 0.73 * width,
                height: 43.0,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    labelStyle: GoogleFonts.lato(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 0.02 * height),
                width: 0.73 * width,
                height: 43.0,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    labelStyle: GoogleFonts.lato(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 0.07 * height),
                width: 0.73 * width,
                height: 43.0,
                child: OutlinedButton(
                  onPressed: () async {
                    final String email = emailController.text;
                    final String password = passwordController.text;

                    try {
                      await _authentication.signInWithEmailAndPassword(
                        email: email,
                        password: password
                      );
                      
                      navigator.push(
                        MaterialPageRoute(
                          builder: (_) => View(email, '주')
                        )
                      );
                    }
                    on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') 
                        print('No user found for that email.');
                      else if (e.code == 'wrong-password')
                        print('Wrong password provided for that user.');
                      loginFailedDlg(e.code);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                  ),
                  child: Center(
                    child: Text(
                      '확인',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 0.03 * height),
                width: 0.73 * width,
                height: 43.0,
                child: OutlinedButton(
                  onPressed: () async {
                    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                    // Obtain the auth details from the request
                    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                    // Create a new credential
                    final credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth?.accessToken,
                      idToken: googleAuth?.idToken,
                    );

                    // Once signed in, return the UserCredential
                    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
                    final email = authResult.user?.email;

                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => View(email!, '주')
                      )
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        child: Image.asset(
                          'images/google_logo.png',
                          width: 25.0,
                        ),
                      ),
                      Text(
                        '구글로 로그인',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
