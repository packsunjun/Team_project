import 'package:flutter/material.dart';

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

    // 학부모 전화번호 입력 제한 및 하이픈 자동 처리
    _parentPhoneController.addListener(() {
      final text = _parentPhoneController.text;
      final newText = _formatPhoneNumber(text);

      // 하이픈 포함 13자 제한
      if (newText.length > 13) {
        _parentPhoneController.value = TextEditingValue(
          text: newText.substring(0, 13),
          selection: TextSelection.fromPosition(
            TextPosition(offset: newText.substring(0, 13).length),
          ),
        );
      } else if (text != newText) {
        _parentPhoneController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: newText.length),
          ),
        );
      }
    });
  }

  String _formatPhoneNumber(String text) {
    final digitsOnly = text.replaceAll(RegExp(r'\D'), '');
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
      final newStudent = Student(
        parentName: parentName,
        parentPhoneNumber: parentPhoneNumber,
        studentName: studentName,
        classDays: classDays,
      );
      widget.onAddStudent(newStudent);
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
