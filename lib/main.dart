import 'dart:math';

import 'package:flutter/material.dart';
import 'Utility.dart';
import 'KeyboardKey.dart'; // android


class CustomKeyboardScreen extends StatefulWidget {
  @override
  _CustomKeyboardScreenState createState() => _CustomKeyboardScreenState();
}

class _CustomKeyboardScreenState extends State<CustomKeyboardScreen> {
  late String tnum;

  @override
  void initState() {
    super.initState();

    tnum = '';
  }

  final keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    [null, '0', '←'],
  ];

  onNumberPress(val) {
    setState(() {
      tnum = val;
    });
  }

  onBackspacePress() {
    setState(() {
      if(tnum.isNotEmpty){
        tnum = tnum.substring(0, tnum.length - 1);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 13, 0),
              child: Icon(Icons.settings),
            ),
          ],
        ),
        drawer: ShowDrawer(context),
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('./assets/background2.png'),
                        fit: BoxFit.cover)),
                padding: const EdgeInsets.all(8.0), // 패딩 추가
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(80, 50, 80, 50),
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: Row(children: [
                          // 리스트 영역
                          // 두 영역을 같게 하려면 expanded를 사용함
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 30, 0),
                                        child: Icon(Icons.sort_by_alpha),
                                      ),
                                      Expanded(
                                          child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(30, 5, 20, 0),
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.7),
                                                blurRadius: 5.0,
                                                spreadRadius: 0.0,
                                                offset: const Offset(0, 0),
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 40, 25, 30),
                                          child: ListView(
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              Container(
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        showDialog(
                                                            context: context,
                                                            builder: (contet){
                                                              return ShowStDialog(context);
                                                            }
                                                        );
                                                      },
                                                      child:
                                                      Container(
                                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                        width: 700,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xffF5F5F5),
                                                          border: Border.all(color: Color(0xffF3F4F4),
                                                              width: 1),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: Text(
                                                          'ㅇㅇㅇ',
                                                          style: TextStyle(
                                                              fontSize: 30),
                                                          textAlign:
                                                          TextAlign.left,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                    ])),
                          ),
                          // 키패드 영역
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.0,
                                    offset: const Offset(0, 0),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        child: Column(
                                          children: [
                                            renderText(),
                                            SizedBox(height: 20),
                                          ],
                                        )),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: renderKeyboard()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])
                    )
                )
            )
        )
    );
  }

  renderKeyboard() {
    return keys.map((row) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: row.map((key) {
          if (key == null) {
            return Expanded(
              child: Container(), // null일 경우 빈 컨테이너로 처리함
            );
          } else if (key == '←') {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: KeyboardKey(
                  label: key,
                  onTap: (_) => onBackspacePress(), // ← 버튼 클릭 시 백스페이스 처리함
                  value: key,
                ),
              ),
            );
          } else {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: KeyboardKey(
                  label: key,
                  onTap: onNumberPress,
                  value: key,
                ),
              ),
            );
          }
        }).toList(),
      );
    }).toList();
  }


  renderText() {
    String display = '';
    TextStyle style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 40,
    );

    if (tnum.length != 0) {
      display = tnum;
      style = style.copyWith(
        color: Colors.black,
      );
    }

    return Expanded(
      child: Center(
        child: Text(
          display,
          style: style,
        ),
      ),
    );
  }
}
