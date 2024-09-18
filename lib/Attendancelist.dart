import 'package:flutter/material.dart';
import 'Utility.dart';

enum Check { In, Out }

class Attendancelist extends StatefulWidget {
  @override
  _AttendancelistState createState() => _AttendancelistState();
}

class _AttendancelistState extends State<Attendancelist> {
  Check _Check1 = Check.In;
  DateTime? _selectedDate1;

  Check _Check2 = Check.In;
  DateTime? _selectedDate2;

  // 날짜 포맷 함수
  String _startDate(DateTime? date) {
    if (date == null) return '날짜를 선택하세요';
    return '${date.year}-${date.month}-${date.day}';
  }

  String _endDate(DateTime? date) {
    if (date == null) return '날짜를 선택하세요';
    return '${date.year}-${date.month}-${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '출결기록',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: ShowDrawer(context),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('./assets/background2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      // Search Box
                      Flexible(
                        flex: 4,
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '검색',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 일정한 간격
                      SizedBox(width: 230),

                      // 라디오 버튼 - 등원, 하원 (Radio  Text로 대체)
                      Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Radio<Check>(
                                  value: Check.In,
                                  groupValue: _Check1,
                                  onChanged: (Check? value) {
                                    setState(() {
                                      if (value != null) {
                                        _Check1 = value;
                                      }
                                    });
                                  },
                                ),
                                Text('등원', style: TextStyle(fontSize: 20)),
                              ],
                            ),
                            SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<Check>(
                                  value: Check.Out,
                                  groupValue: _Check2,
                                  onChanged: (Check? value) {
                                    setState(() {
                                      if (value != null) {
                                        _Check2 = value;
                                      }
                                    });
                                  },
                                ),
                                Text('하원', style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // 일정한 간격
                      SizedBox(width: 12),

                      // 날짜 선택
                      Flexible(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.calendar_month),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                ).then((selectedDate) {
                                  setState(() {
                                    _selectedDate1 = selectedDate;
                                  });
                                });
                              },
                            ),
                            SizedBox(width: 8),
                            Text(
                              _selectedDate1 != null
                                  ? _startDate(_selectedDate1)
                                  : '날짜 선택',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text('   ~ '),
                            IconButton(
                              icon: Icon(Icons.calendar_month),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                ).then((selectedDate) {
                                  setState(() {
                                    _selectedDate2 = selectedDate;
                                  });
                                });
                              },
                            ),

                            SizedBox(width: 8),
                            Text(
                              _selectedDate2 != null
                                  ? _endDate(_selectedDate2)
                                  : '날짜 선택',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30, 5, 20, 0),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 40, 25, 30),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            width: 700,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('ㅁㅁㅁ 등원', style: TextStyle(fontSize: 25), textAlign: TextAlign.left),
                                Text('2024-00-00', style: TextStyle(fontSize: 25), textAlign: TextAlign.right),
                              ],
                            ),
                          ),
                          Container(
                            width: 700,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('ㅁㅁㅁ 하원', style: TextStyle(fontSize: 25), textAlign: TextAlign.left),
                                Text('2024-00-00', style: TextStyle(fontSize: 25), textAlign: TextAlign.right),
                              ],
                            ),
                          ),
                          Container(
                            width: 700,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('ㅁㅁㅁ 등원', style: TextStyle(fontSize: 25), textAlign: TextAlign.left),
                                Text('2024-00-00', style: TextStyle(fontSize: 25), textAlign: TextAlign.right),
                              ],
                            ),
                          ),
                          Container(
                            width: 700,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('ㅁㅁㅁ 하원', style: TextStyle(fontSize: 25), textAlign: TextAlign.left),
                                Text('2024-00-00', style: TextStyle(fontSize: 25), textAlign: TextAlign.right),
                              ],
                            ),
                          ),
                          // 다른 Container 위젯들도 같은 방식으로 추가
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}