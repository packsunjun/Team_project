import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      // 먼저 받아옴
      home: FutureBuilder(
          future: _checkLogin(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data == true){
              return CustomKeyboardScreen();
            } else{
              return Login();
            }
          }
      ),
    );
  }
}

Future<bool> _checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('로그인') ?? false;
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class _LoginState extends State<Login> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('./assets/background.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 200, 0, 200),
                            child: Form(
                              child: Theme(
                                  data: ThemeData(
                                      primaryColor: Colors.grey,
                                      inputDecorationTheme: InputDecorationTheme(
                                          labelStyle: TextStyle(
                                              color: Colors.grey, fontSize: 20)
                                      )
                                  ),
                                  child: Builder(
                                      builder: (context){
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                                              child: const Text(
                                                '안민J컴퓨터',
                                                style: TextStyle(
                                                    fontSize: 50, fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                              width: 400,
                                              child: TextField(
                                                  controller: controller,
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(),
                                                      labelText: '아이디')
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              width: 400,
                                              child: TextField(
                                                obscureText: true,
                                                controller: controller2,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: '비밀번호',
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 400,
                                              height: 50,
                                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xff8170EC),
                                                  surfaceTintColor: const Color(0xff8170EC),
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  textStyle: const TextStyle(fontSize: 20),
                                                ),
                                                onPressed: () async {
                                                  log('아이디 : ${controller.text}, 비밀번호: ${controller2.text} ');
                                                  if (controller.text == '0' &&
                                                      controller2.text == '0') {
                                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    await prefs.setBool('로그인', true);

                                                    Navigator.push(
                                                        context, MaterialPageRoute(
                                                        builder: (BuildContext context) =>
                                                            CustomKeyboardScreen()
                                                    )
                                                    );
                                                  }
                                                },
                                                child: const Text('로그인'),
                                              ),
                                            ),
                                          ],
                                        );
                                      })

                              ),
                            ),
                          )
                      )
                  ),]
                ,
              )
              ,
            )
        )
    ,
    );
  }
}
