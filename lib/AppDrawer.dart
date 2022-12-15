import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:term_project/LoginForm.dart';

class AppDrawer extends StatelessWidget {
  final String id;
  final _auth = FirebaseAuth.instance;

  AppDrawer (@required this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/user.png'),
                backgroundColor: Colors.white,
              ),
              accountName: Text(''),
              accountEmail: Text('$id'),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0)
                )
              ),
          ),
          ListTile(
            leading: Icon(
              Icons.storage_rounded,
              color: Colors.grey[850],
            ),
            title: Text('보관함'),
            onTap: () {
              print('Storage is clicked');
            },
            trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: Colors.grey[850],
            ),
            title: Text('로그아웃'),
            onTap: () async{
              print('Log out is clicked');
              try{
                await _auth.signOut();
                print('sign out complete');
              } catch(e){
                print('sign out failed');
                print(e.toString());
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginForm()),
              );
            },
            trailing: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}