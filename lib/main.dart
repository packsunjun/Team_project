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

class Student {
  String parentName;
  String parentPhoneNumber;
  String studentName;
  List<String> classDays;

  Student({
    required this.parentName,
    required this.parentPhoneNumber,
    required this.studentName,
    required this.classDays,
  });
}

// 학생 관리 페이지
class StudentManagementPage extends StatefulWidget {
  @override
  _StudentManagementPageState createState() => _StudentManagementPageState();
}

class _StudentManagementPageState extends State<StudentManagementPage> {
  final List<Student> _students = [];
  List<Student> _filteredStudents = [];
  List<String> _selectedDays = [];
  String _searchQuery = '';

  void _addStudent(Student student) {
    setState(() {
      _students.add(student);
      _filterStudents();
    });
  }

  void _updateStudent(Student updatedStudent) {
    setState(() {
      final index = _students.indexWhere((s) => s.studentName == updatedStudent.studentName);
      if (index != -1) {
        _students[index] = updatedStudent;
        _filterStudents();
      }
    });
  }

  void _deleteStudent(String studentName) {
    setState(() {
      _students.removeWhere((s) => s.studentName == studentName);
      _filterStudents();
    });
  }

  void _filterStudents() {
    setState(() {
      _filteredStudents = _students.where((student) {
        final matchesSearchQuery = student.studentName.contains(_searchQuery);
        final matchesDaysFilter = _selectedDays.isEmpty ||
            student.classDays.any((day) => _selectedDays.contains(day));
        return matchesSearchQuery && matchesDaysFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('학생 관리'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // 검색 및 필터링 영역
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: '학생 이름 검색',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                        _filterStudents();
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: ['월', '화', '수', '목', '금', '토', '일']
                        .map((day) => FilterChip(
                      label: Text(day),
                      selected: _selectedDays.contains(day),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedDays.add(day);
                          } else {
                            _selectedDays.remove(day);
                          }
                          _filterStudents();
                        });
                      },
                    ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // 학생 리스트
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '총 학생 수: ${_filteredStudents.length}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredStudents.length,
              itemBuilder: (context, index) {
                final student = _filteredStudents[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    title: Text('${index + 1}. ${student.studentName}'),
                    subtitle: Text('수업 요일: ${student.classDays.join(', ')}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => EditStudentDialog(
                                student: student,
                                onUpdateStudent: _updateStudent,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('학생 삭제'),
                                content: Text('정말로 이 학생을 삭제하시겠습니까?'),
                                actions: [
                                  TextButton(
                                    child: Text('취소'),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                  ElevatedButton(
                                    child: Text('삭제'),
                                    onPressed: () {
                                      _deleteStudent(student.studentName);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddStudentDialog(onAddStudent: _addStudent),
          );
        },
      ),
    );
  }
}


class AddStudentDialog extends StatefulWidget {
  final void Function(Student) onAddStudent;

  AddStudentDialog({required this.onAddStudent});

  @override
  _AddStudentDialogState createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final _parentNameController = TextEditingController();
  final _parentPhoneController = TextEditingController();
  final _studentNameController = TextEditingController();
  List<String> _selectedDays = [];

  @override
  void initState() {
    super.initState();
    _parentPhoneController.addListener(() {
      final text = _parentPhoneController.text;
      // 자동 하이픈 추가
      if (text.length > 3 && !text.contains('-')) {
        final formatted = text.replaceRange(3, 4, '-');
        _parentPhoneController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.fromPosition(TextPosition(offset: formatted.length)),
        );
      }
      // 입력 길이 제한
      if (text.length > 13) { // 예를 들어, 13자는 하이픈 포함 11자리 전화번호
        _parentPhoneController.value = TextEditingValue(
          text: text.substring(0, 13),
          selection: TextSelection.fromPosition(TextPosition(offset: text.substring(0, 13).length)),
        );
      }
    });
  }

  void _onSubmit() {
    final parentName = _parentNameController.text;
    final parentPhoneNumber = _parentPhoneController.text;
    final studentName = _studentNameController.text;
    final classDays = _selectedDays;

    if (parentName.isNotEmpty && studentName.isNotEmpty) {
      final student = Student(
        parentName: parentName,
        parentPhoneNumber: parentPhoneNumber,
        studentName: studentName,
        classDays: classDays,
      );
      widget.onAddStudent(student);
      Navigator.of(context).pop();
    } else {
      // 유효성 검사 실패 시 알림
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('오류'),
          content: Text('학부모 이름과 학생 이름을 입력해야 합니다.'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('학생 추가'),
      content: Container(
        width: 300,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            TextFormField(
              controller: _parentNameController,
              decoration: InputDecoration(labelText: '학부모 이름'),
            ),
            TextFormField(
              controller: _parentPhoneController,
              decoration: InputDecoration(labelText: '학부모 전화번호'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: _studentNameController,
              decoration: InputDecoration(labelText: '학생 이름'),
            ),
            MultiSelectCheckbox(
              selectedDays: _selectedDays,
              onSelectionChanged: (days) {
                setState(() {
                  _selectedDays = days;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('취소'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('추가'),
          onPressed: _onSubmit,
        ),
      ],
    );
  }
}

class EditStudentDialog extends StatefulWidget {
  final Student student;
  final void Function(Student) onUpdateStudent;

  EditStudentDialog({required this.student, required this.onUpdateStudent});

  @override
  _EditStudentDialogState createState() => _EditStudentDialogState();
}

class _EditStudentDialogState extends State<EditStudentDialog> {
  late final TextEditingController _parentNameController;
  late final TextEditingController _parentPhoneController;
  late final TextEditingController _studentNameController;
  List<String> _selectedDays = [];

  @override
  void initState() {
    super.initState();
    _parentNameController = TextEditingController(text: widget.student.parentName);
    _parentPhoneController = TextEditingController(text: widget.student.parentPhoneNumber);
    _studentNameController = TextEditingController(text: widget.student.studentName);
    _selectedDays = List.from(widget.student.classDays);

    _parentPhoneController.addListener(() {
      final text = _parentPhoneController.text;
      final newText = _formatPhoneNumber(text);

      if (text != newText) {
        _parentPhoneController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(TextPosition(offset: newText.length)),
        );
      }

      // 입력 길이 제한
      if (newText.length > 13) { // 하이픈 포함 11자리 전화번호
        _parentPhoneController.value = TextEditingValue(
          text: newText.substring(0, 13),
          selection: TextSelection.fromPosition(TextPosition(offset: newText.substring(0, 13).length)),
        );
      }
    });
  }

  String _formatPhoneNumber(String text) {
    final digitsOnly = text.replaceAll(RegExp(r'\D'), ''); // 숫자만 추출
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 3 || i == 7) {
        buffer.write('-');
      }
      buffer.write(digitsOnly[i]);
    }

    return buffer.toString();
  }

  void _onSubmit() {
    final parentName = _parentNameController.text;
    final parentPhoneNumber = _parentPhoneController.text;
    final studentName = _studentNameController.text;
    final classDays = _selectedDays;

    if (parentName.isNotEmpty && studentName.isNotEmpty) {
      final updatedStudent = Student(
        parentName: parentName,
        parentPhoneNumber: parentPhoneNumber,
        studentName: studentName,
        classDays: classDays,
      );
      widget.onUpdateStudent(updatedStudent);
      Navigator.of(context).pop();
    } else {
      // 유효성 검사 실패 시 알림
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('오류'),
          content: Text('학부모 이름과 학생 이름을 입력해야 합니다.'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('학생 수정'),
      content: Container(
        width: 300,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            TextFormField(
              controller: _parentNameController,
              decoration: InputDecoration(labelText: '학부모 이름'),
            ),
            TextFormField(
              controller: _parentPhoneController,
              decoration: InputDecoration(labelText: '학부모 전화번호'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: _studentNameController,
              decoration: InputDecoration(labelText: '학생 이름'),
            ),
            MultiSelectCheckbox(
              selectedDays: _selectedDays,
              onSelectionChanged: (days) {
                setState(() {
                  _selectedDays = days;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('취소'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('수정'),
          onPressed: _onSubmit,
        ),
      ],
    );
  }
}

class MultiSelectCheckbox extends StatefulWidget {
  final List<String> selectedDays;
  final void Function(List<String>) onSelectionChanged;

  MultiSelectCheckbox({
    required this.selectedDays,
    required this.onSelectionChanged,
  });

  @override
  _MultiSelectCheckboxState createState() => _MultiSelectCheckboxState();
}

class _MultiSelectCheckboxState extends State<MultiSelectCheckbox> {
  final List<String> _daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _daysOfWeek.map((day) {
        return CheckboxListTile(
          title: Text(day),
          value: widget.selectedDays.contains(day),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                if (!widget.selectedDays.contains(day)) {
                  widget.selectedDays.add(day);
                }
              } else {
                widget.selectedDays.remove(day);
              }
              widget.selectedDays.sort((a, b) => _daysOfWeek.indexOf(a).compareTo(_daysOfWeek.indexOf(b)));
              widget.onSelectionChanged(widget.selectedDays);
            });
          },
        );
      }).toList(),
    );
  }
}
