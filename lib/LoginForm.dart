import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final emailController_l = TextEditingController();
  final passwordController_l = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
        padding: EdgeInsets.fromLTRB(40 * fem, 127.5 * fem, 39 * fem, 240 * fem),
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
                    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 27.5 * fem),
                    child:  
                      Text(
                        '로그인',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato (
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2125 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                  ),
              ),
              Container(
                width: 280 * fem,
                child:  
                  TextField(
                    controller: emailController_l,
                    decoration: InputDecoration(
                      labelText: '이메일',
                      labelStyle: GoogleFonts.lato(
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * ffem / fem,
                      ),
                    ),
                  ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 40 * fem),
                width: 280 * fem,
                child:  
                  TextField(
                    controller: passwordController_l,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: GoogleFonts.lato(
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * ffem / fem,
                      ),
                    ),
                  ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
                width: 280 * fem,
                height: 40 * fem,
                child: OutlinedButton(
                  onPressed: () {
                    // login
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ),
                    // );
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
                              '확인',
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
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
                width: 280 * fem,
                height: 40 * fem,
                child: OutlinedButton(
                  onPressed: () {
                    // goto naver login form
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ,
                    // );
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
                              '네이버로 로그인',
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
            ],
          ),
      )
    );
  }
}