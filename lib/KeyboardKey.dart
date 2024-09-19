import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardKey extends StatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  KeyboardKey({
    required this.label,
    required this.onTap,
    required this.value,
  });

  @override
  _KeyboardKeyState createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  renderLabel() {
    if (widget.label == null) {
      // label이 null일 경우 빈 컨테이너를 반환하여 빈 공간을 차지
      return Container();
    }

    if (widget.label is String) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return widget.label;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.label == null) {
      // label이 null일 경우, 빈 공간을 위한 컨테이너 반환
      return AspectRatio(
        aspectRatio: 2, // 기존 키의 비율을 유지
        child: Container(), // 빈 컨테이너로 처리
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: InkWell(
        onTap: () {
          widget.onTap(widget.value);
        },
        child: AspectRatio(
          aspectRatio: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffc8c8c8),
              shape: BoxShape.circle
            ),
            child: Center(
              child: renderLabel(),
            ),
          ),
        ),
      ),
    );
  }
}
