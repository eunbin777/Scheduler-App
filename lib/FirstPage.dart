import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/LoginForm.dart';
import 'package:term_project/RegistrationForm.dart';

// class FirstPage extends StatefulWidget {
//   @override
//   _FirstPage createState() => _FirstPage();
// }

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Container(
      padding: EdgeInsets.fromLTRB(40 * fem, 220 * fem, 40 * fem, 250 * fem),
      width: double.infinity,
      decoration: BoxDecoration (
        color: Color(0xffffffff),
      ),
      child:  
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child:  
                Container(
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 45.5 * fem),
                  constraints: BoxConstraints (
                    maxWidth: 230 * fem,
                  ),
                  child:  
                    Text(
                      '더 안전한 데이터 관리를 위해\n로그인 해주세요',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato (
                        fontSize: 19 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
              height: 40 * fem,
              child: OutlinedButton(
                onPressed: () {
                  // goto login form
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginForm()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xff000000)),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
                child:  
                  Center(
                    child:  
                      Center(
                        child:  
                          Text(
                            '로그인',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato (
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2125 * ffem / fem,
                              color: Color(0xff000000),
                            ),
                          ),
                      ),
                  ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
              height: 40 * fem,
              child: OutlinedButton(
                onPressed: () {
                  // goto registration form
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationForm()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xff000000),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
                child:  
                  Center(
                    child:  
                      Center(
                        child:  
                          Text(
                            '가입하기',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato (
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2125 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                      ),
                  ),
              ),
            ),
          ],
        ),
    );
  }
}