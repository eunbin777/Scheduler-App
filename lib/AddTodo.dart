import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/Todo.dart';
import 'package:intl/intl.dart';

class AddTodo extends StatefulWidget {
  final DateTime selectedDay;

  AddTodo(@required this.selectedDay, {Key? key}) : super(key : key);

  _AddTodo createState() => _AddTodo();
}

class _AddTodo extends State<AddTodo> {
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => 
          Navigator.pop(context, Todo(task, false)),
          label: Text("+"),
      ),
    );
  }
}
