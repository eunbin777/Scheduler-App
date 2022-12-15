import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:term_project/Todo.dart';

class ModifyTodoForm extends StatefulWidget {
  final DateTime selectedDay;

  ModifyTodoForm(@required this.selectedDay, {Key? key}) : super(key : key);

  _ModifyTodoForm createState() => _ModifyTodoForm();
}

class _ModifyTodoForm extends State<ModifyTodoForm> {
  final taskController = TextEditingController();  // title
  final sharingUserController = TextEditingController();  // userEmail

  @override
  void dispose() {
    taskController.dispose();
    sharingUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String task = taskController.text;
    String? sharingUser = sharingUserController.text;
    DateTime date = widget.selectedDay;

    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
        padding: EdgeInsets.fromLTRB(20 * fem, 20 * fem, 20 * fem, 20 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 100 * fem, 0 * fem, 23 * fem),
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  hintText: '제목',
                  hintStyle: GoogleFonts.lato (
                    fontSize: 18 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.2125 * ffem / fem,
                    color: Color(0x7f000000),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 15 * ffem, 44 * fem, 29 * fem),
              width: 260 * fem,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 15 * ffem, 44 * fem, 5 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                          width: 18 * fem,
                          height: 18 * fem,
                          child: Image.asset(
                            "images/delete.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context, Todo("null", false));
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5 * fem, 0 * fem, 0 * fem, 1 * fem),
                            child: Text(
                              '삭제',
                              style: GoogleFonts.lato(
                                fontSize: 11 * fem,
                                fontWeight: FontWeight.w500,
                                height: 1.2125 * ffem / fem,
                                color: Color(0xb2000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => 
          // if(sharingUser != null && alarm != null)
          Navigator.pop(context, Todo(task, false)),
          label: Text("+"),
      ),
    );
  }
}