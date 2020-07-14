import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/components/searchDelegate.dart';

class appBarWidget extends StatelessWidget {
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: _appBarLeading(context),
      title: _appBarTitle(context),
    );
  }
  // leading
  _appBarLeading(context) {
    return IconButton(
      color: Color(0xffffffff),
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
  // title
  _appBarTitle(context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(68),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            child: Container(
              height: 32,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 0),
              width: ScreenUtil().setWidth(460),
              decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Container(
                    height: 26,
                    // padding: EdgeInsets.only(top: 4, bottom: 4),
                    // rheight: 26,
                    // child: Text('手机', style: TextStyle(color: Color(0xff888888),fontSize: ScreenUtil().setSp(30)),),
                    child: InputChip(
                        backgroundColor: Color(0xff888888),
                        // labelPadding: EdgeInsets.only(bottom: 20),
                        onPressed: () {
                          print('input chip');
                        },
                        onDeleted: () {},
                        label: Text(
                          '手机',
                        ),
                        labelStyle:
                        TextStyle(color: Colors.white, fontSize: 12),
                        deleteIcon: Icon(
                          Icons.close,
                          size: ScreenUtil().setSp(26),
                        ),
                        deleteIconColor: Colors.white),
                  ),
                  Container(
                    child: IconButton(
                      color: Color(0xffF8F8F8),
                      icon: Icon(
                        Icons.camera_alt,
                        size: ScreenUtil().setSp(40),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          IconButton(
              alignment: Alignment.topCenter,
              color: Color(0xffffffff),
              icon: Icon(
                Icons.more_horiz,
                size: 22,
              ),
              onPressed: () {
                print('bbbb');
              })
        ],
      ),
    );
  }

}
