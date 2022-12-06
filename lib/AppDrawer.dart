import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
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
            otherAccountsPictures: <Widget>[
              // 다른 계정 이미지[] set
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/profile2.png'),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/profile2.png'),
              )
            ],
            accountName: Text('김지안'),
            accountEmail: Text('j0012a@naver.com'),
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
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.grey[850],
            ),
            title: Text('Home'),
            onTap: () {
              print('Home is clicked');
            },
            trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.grey[850],
            ),
            title: Text('Setting'),
            onTap: () {
              print('Setting is clicked');
            },
            trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: Colors.grey[850],
            ),
            title: Text('보관함'),
            onTap: () {
              print('Q&A is clicked');
            },
            trailing: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}