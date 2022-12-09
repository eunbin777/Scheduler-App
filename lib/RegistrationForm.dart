import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:term_project/LoginForm.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationForm createState() => _RegistrationForm();
}

class _RegistrationForm extends State<RegistrationForm> {
  final _authentication = FirebaseAuth.instance;
  final emailController_r = TextEditingController();  // TextField 값 접근: emailController.text
  final passwordController_r = TextEditingController();
  final checkPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController_r.dispose();
    passwordController_r.dispose();
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
        padding: EdgeInsets.fromLTRB(40 * fem, 150 * fem, 40 * fem, 260 * fem),
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
                    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 27.5 * fem),
                    child:  
                      Text(
                        '회원가입',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2125 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                  ), 
              ),
              Container(
                width: double.infinity,
                child:  
                  TextField(
                    controller: emailController_r,
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
                width: double.infinity,
                child:  
                  TextField(
                    controller: passwordController_r,
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
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 40 * fem),
                width: double.infinity,
                child:  
                  TextField(
                    controller: checkPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호 확인',
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
                width: double.infinity,
                height: 40 * fem,
                child: OutlinedButton(
                  onPressed: () async{
                    print("Button pressed");
                    try {
                      String email = emailController_r.text;
                      print("email: $email");
                      String password = passwordController_r.text;
                      final newUser = await _authentication.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      newUser.user?.updateDisplayName(email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                    // login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginForm()),
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
                              '가입',
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
      )
    );
  }
}