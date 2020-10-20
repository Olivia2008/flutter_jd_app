import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget(this.data);
  final List data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Text('$data')
    );
  }
}