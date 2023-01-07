import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Scheduler/user/FirstPage.dart';

class AppDrawer extends StatelessWidget {
  final String email;
  final _auth = FirebaseAuth.instance;

  AppDrawer(this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('images/user.png'),
                backgroundColor: Colors.white,
              ),
              accountName: const Text(''),
              accountEmail: Text(email),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)
                )
              ),
          ),
          ListTile(
            leading: const Icon(
              Icons.storage_rounded,
              color: Colors.black,
            ),
            title: const Text('보관함'),
            onTap: () {
              print('Storage is clicked');
            },
            trailing: const Icon(Icons.add),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              color: Colors.black,
            ),
            title: const Text('로그아웃'),
            onTap: () async{
              final navigator = Navigator.of(context);
              print('Log out is clicked');

              try{
                await _auth.signOut();
                print('sign out complete');
              }
              catch(e){
                print('sign out failed');
                print(e.toString());
              }
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => const FirstPage(),
                ),
              );
            },
            trailing: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}