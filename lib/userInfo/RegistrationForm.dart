import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Scheduler/userInfo/LoginForm.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _authentication = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final checkPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    checkPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    void registrationFailedDlg(String error) {
      String message = '';

      switch(error) {
        case 'password-mismatch':
          message = '비밀번호가 일치하지 않습니다.';
          break;
        case 'weak-password':
          message = '비밀번호가 유효하지 않습니다.';
          break;
        case 'email-already-in-use':
          message = '이미 존재하는 이메일입니다.';
          break;
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('회원가입 실패'),
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

    void registrationSuccessDlg() {
      final navigator = Navigator.of(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('회원가입 성공'),
            content: const Text('가입이 완료되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  navigator.push(
                    MaterialPageRoute(
                      builder: (_) => const LoginForm(),
                    )
                  );
                },
                child: const Text('확인'),
              )
            ],
          );
        }
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: height * 0.23),
        child: Column(
          children: [
            Center(
              child: Text(
                '회원가입',
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
                margin: EdgeInsets.only(top: 0.02 * height),
                width: 0.73 * width,
                height: 43.0,
                child: TextField(
                  controller: checkPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호 확인',
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
                    final String checkPassword = checkPasswordController.text;

                    try {
                      if(password == checkPassword) {
                        await _authentication.createUserWithEmailAndPassword(
                          email: email,
                          password: password
                        );
                        registrationSuccessDlg();
                      }
                      else {
                        registrationFailedDlg('password-mismatch');
                      }
                    }
                    on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') 
                        print('The password provided is too weak.');
                      
                      else if (e.code == 'email-already-in-use') 
                        print('The account already exists for that email.');
                      
                      registrationFailedDlg(e.code);
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
                      '가입하기',
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
          ],
        ),
      )
    );
  }
}
