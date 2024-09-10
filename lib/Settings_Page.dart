import 'package:flutter/material.dart';

// 설정 페이지
class PageView5_Settings extends StatefulWidget {
  const PageView5_Settings({super.key});

  @override
  _PageView5_SettingsState createState() => _PageView5_SettingsState();
}

class _PageView5_SettingsState extends State<PageView5_Settings> {
  bool _isCodeHidden = true;
  bool _autoCheckInOut = false;

  void _toggleCodeVisibility() {
    setState(() {
      _isCodeHidden = !_isCodeHidden;
    });
  }

  void _toggleAutoCheckInOut(bool value) {
    setState(() {
      _autoCheckInOut = value;
    });
  }

  void _navigateToPasswordChange(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordChangePage(),
      ),
    );
  }

  void _navigateToAttendanceCode(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceCodePage(
          isCodeHidden: _isCodeHidden,
          toggleCodeVisibility: _toggleCodeVisibility,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정 페이지'),
      ),
      body: ListView(
        children: [
          // 비밀번호 변경으로 이동
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('비밀번호 변경'),
            onTap: () => _navigateToPasswordChange(context),
            trailing: Icon(Icons.navigate_next),
          ),
          Divider(),

          // 등하원 자동처리로 이동
          SwitchListTile(
            title: Text('등하원 자동처리'),
            value: _autoCheckInOut,
            onChanged: _toggleAutoCheckInOut,
            secondary: Icon(Icons.school),
          ),
          Divider(),

          // 출석체크 코드 숨기기 설정
          ListTile(
            leading: Icon(Icons.code),
            title: Text('출석체크 코드 숨기기'),
            trailing: IconButton(
              icon: Icon(_isCodeHidden ? Icons.visibility_off : Icons.visibility),
              onPressed: _toggleCodeVisibility,
            ),
          ),
        ],
      ),
    );
  }
}

// 비밀번호 변경 페이지
class PasswordChangePage extends StatefulWidget {
  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  String _oldPassword = '';
  String _newPassword = '';

  void _changePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('비밀번호가 성공적으로 변경되었습니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호 변경'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: '현재 비밀번호'),
              onChanged: (value) {
                setState(() {
                  _oldPassword = value;
                });
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: '새 비밀번호'),
              onChanged: (value) {
                setState(() {
                  _newPassword = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('비밀번호 변경'),
            ),
          ],
        ),
      ),
    );
  }
}

// 출석 체크 코드 페이지
class AttendanceCodePage extends StatelessWidget {
  final bool isCodeHidden;
  final VoidCallback toggleCodeVisibility;

  AttendanceCodePage({required this.isCodeHidden, required this.toggleCodeVisibility});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('출석 체크 코드'),
      ),
      body: Center(
        child: Text(
          isCodeHidden ? '출석 체크 코드가 숨겨져 있습니다.' : '출석 체크 코드: 1234',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleCodeVisibility,
        child: Icon(isCodeHidden ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }
}
