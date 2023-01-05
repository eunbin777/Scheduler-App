import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Scheduler/user/LoginForm.dart';
import 'package:Scheduler/user/RegistrationForm.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: height * 0.28),
        child: Column(
          children: [
            Center(
              child: Text(
                '더 안전한 데이터 관리를 위해\n로그인 해주세요',
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
                child: OutlinedButton(
                  onPressed: () {
                    // goto loginForm
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginForm()
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                  ),
                  child: Center(
                    child: Text(
                      '로그인',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
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
                  onPressed: () {
                    // goto registrationForm
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationForm()
                      ),
                    );
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
      ),
    );
  }
}