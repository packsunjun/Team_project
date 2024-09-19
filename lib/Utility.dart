import 'package:flutter/material.dart';
import 'main.dart';
import 'Attendancelist.dart';

Widget ShowDrawer(BuildContext context) {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.black54,
        ),
        child: Text(
          '안민J컴퓨터',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.message),
        title: Text(
          '홈',
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomKeyboardScreen()));
        },
      ),
      ListTile(
        leading: Icon(Icons.account_circle),
        title: Text(
          '학생관리',
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  // 임시등록
                  builder: (context) => CustomKeyboardScreen()));
        },
      ),
      ListTile(
        leading: Icon(Icons.person_pin_rounded),
        title: Text(
          '출석현황',
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Attendancelist()));
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('설정', style: TextStyle(fontSize: 18)),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  // 임시등록
                  builder: (context) => Attendancelist()));
        },
      ),
    ]),
  );
}

Widget ShowStDialog(BuildContext context) {
  return Dialog(
    child: Container(
        width: 550,
        height: 350,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text('이름 : ㅇㅇㅇ ', style: TextStyle(fontSize: 25)),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 150,
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: TextButton(
                          onPressed: () {},
                          child: Text('등원',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black)),
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.blue[300]),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))))),
                    ),
                    SizedBox(
                      width: 200,
                      height: 150,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '하원',
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.yellow[300]),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))))),
                    )
                  ]),
            ])),
  );
}
