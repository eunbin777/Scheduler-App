import 'package:flutter/material.dart';
import 'package:term_project/LoginForm.dart';

class AppDrawer extends StatelessWidget {
  final String id;

  AppDrawer (@required this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // 프로젝트에 assets 폴더 생성 후 이미지 2개 넣기
            // pubspec.yaml 파일에 assets 주석에 이미지 추가하기
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                // 현재 계정 이미지 set
                backgroundImage: AssetImage('assets/profile.png'),
                backgroundColor: Colors.white,
              ),
              accountName: Text(''),
              accountEmail: Text('$id'),
              onDetailsPressed: () {
                print('arrow is clicked');
              },
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0)
                )
              ),
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.home,
          //     color: Colors.grey[850],
          //   ),
          //   title: Text('Home'),
          //   onTap: () {
          //     print('Home is clicked');
          //   },
          //   trailing: Icon(Icons.add),
          // ),
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
            onTap: () {
              print('Logout is clicked');
            },
            trailing: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}