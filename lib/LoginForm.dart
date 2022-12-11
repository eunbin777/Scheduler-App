// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/Calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final _authentication = FirebaseAuth.instance;
  final emailController_l = TextEditingController();
  final passwordController_l = TextEditingController();

  @override
  void dispose() {
    emailController_l.dispose();
    passwordController_l.dispose();
    super.dispose();
  }

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
                  onPressed: () async{
                    String email = emailController_l.text;
                    String password = passwordController_l.text;
                    try {
                      final newUser = await _authentication
                          .signInWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser.user != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => Calendar(email)
                          )
                        );
                      } 
                    }
                    on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      }
                      else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
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
                  onPressed: () async{
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
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Calendar(email!)
                    ));
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
                              '구글로 로그인',
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