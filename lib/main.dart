import 'package:dddddd/Settings_Page.dart';
import 'package:dddddd/Student_Mng.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageView1_Home(), // 첫 페이지 설정
    );
  }
}

// 홈 페이지
class PageView1_Home extends StatefulWidget {
  const PageView1_Home({super.key});

  @override
  _PageView1_HomeState createState() => _PageView1_HomeState();
}

class _PageView1_HomeState extends State<PageView1_Home> {
  String _input = '';

  void _onButtonClick(String value) {
    setState(() {
      if (_input.length < 4) {
        _input += value;
      }

      if (_input.length == 4) {
        _showConfirmationDialog();
      }
    });
  }

  void _onBackspace() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
      }
    });
  }

  void _onCheck() {
    if (_input.length == 4) {
      _showConfirmationDialog();
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('확인'),
          content: Text('입력된 번호는 $_input 입니다.'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _input = ''; // 입력 초기화
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('학원 출석 앱', style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.lightGreen,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('character.png'),
              ),
              accountName: Text('안민J 컴퓨터', style: TextStyle(fontSize: 20)),
              accountEmail: Text('TEL. 051-527-5002'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              iconColor: Colors.purple,
              focusColor: Colors.purple,
              title: Text('홈'),
              onTap: () {
                Navigator.pop(context);
              },
              trailing: Icon(Icons.navigate_next),
            ),
            ListTile(
              leading: Icon(Icons.scale),
              iconColor: Colors.purple,
              focusColor: Colors.purple,
              title: Text('학생 관리'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentManagementPage(),
                  ),
                );
              },
              trailing: Icon(Icons.navigate_next),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              iconColor: Colors.purple,
              focusColor: Colors.purple,
              title: Text('설정'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageView5_Settings(),
                  ),
                );
              },
              trailing: Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // 왼쪽 이미지 영역
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Image.asset('1.jpg', fit: BoxFit.cover),
            ),
          ),
          // 오른쪽 숫자 패드 및 입력된 숫자 표시 영역
          Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(height: 20),
                // 입력된 숫자를 표시하는 부분
                Text(
                  _input,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(10.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      if (index < 9) {
                        return ElevatedButton(
                          onPressed: () => _onButtonClick('${index + 1}'),
                          child: Text('${index + 1}'),
                        );
                      } else if (index == 9) {
                        return ElevatedButton(
                          onPressed: _onBackspace,
                          child: Icon(Icons.backspace),
                        );
                      } else if (index == 10) {
                        return ElevatedButton(
                          onPressed: () => _onButtonClick('0'),
                          child: Text('0'),
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: _onCheck,
                          child: Icon(Icons.check),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // 이미 홈 페이지에 있으므로 아무 동작을 하지 않도록 설정
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageView5_Settings(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


