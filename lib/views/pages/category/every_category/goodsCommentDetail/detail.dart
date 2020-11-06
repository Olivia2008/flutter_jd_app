import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:netease_news/components/icons/tipIcon.dart';

class DetailWidget extends StatelessWidget {
  DetailWidget(this.detailKey);
  final GlobalKey detailKey;


  Map<int, TableColumnWidth> _columnWidth = {
    0: FixedColumnWidth(ScreenUtil().setWidth(200)),
    1: FixedColumnWidth(ScreenUtil().setWidth(515))
  };

  @override
  Widget build(BuildContext context) {
    return Provide<GoodsCommentDetailProvide>(
      builder: (context, child, provider) {
        if (provider.goodsInfo.data.result.params != null) {
          return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: Column(
                children: [
                  _title(context),
                  _table(context, provider.goodsInfo.data.result.params)
                ],
              ));
        } else {
          return Text('No Data');
        }
      },
    );
  }

  
  Widget _title(context) {
    return Container(
      key: detailKey,
      height: ScreenUtil().setHeight(50),
      child: Row(
        children: [
          TipIcon(
            width: 3.0,
            height: 16.0,
            colorList: [Color(0xfff5503a), Color(0xfffad1cb)],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('详情',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(32)))),
        ],
      ),
    );
  }

  Widget _table(context, data) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.details, size: 10),
              SizedBox(width: 6),
              Text('规格参数')
            ],
          ),
          SizedBox(height: 6),
          _tableCode(context, data.code),
          _tableItems(context, data.paramList),
        ],
      ),
    );
  }

  Widget _tableCode(context, data) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(color: Color(0xfff2f2f2)),
      columnWidths: _columnWidth,
      children: [
        TableRow(children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              '商品编号',
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8),
            child: Text(
              data,
              style: TextStyle(color: Color(0xff888888)),
            ),
          )
        ]),
      ],
    );
  }

  Widget _tableItems(context, data) {
    return Container(
      child: Column(
        children: List.generate(data.length, (index) {
          return Column(
            children: [
              _tableItemTitle(context, data[index]),
              _tableItemTable(context, data[index].desc)
            ],
          );
        }),
      ),
    );
  }

  Widget _tableItemTitle(context, data) {
    return Container(
      width: ScreenUtil().setWidth(715),
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(color: Color(0xfff2f2f2)),
        right: BorderSide(color: Color(0xfff2f2f2)),
      )),
      child: Container(
          width: ScreenUtil().setWidth(200),
          child: Text(
            '${data.title}',
            style: TextStyle(
                color: Color(0xff333333), fontWeight: FontWeight.w500),
          )),
    );
  }

  Widget _tableItemTable(context, data) {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Color(0xfff2f2f2)),
        columnWidths: _columnWidth,
        children: List.generate(data.length, (idx) {
          return TableRow(children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                '${data[idx].label}',
                style: TextStyle(color: Color(0xff888888)),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8),
              child: Text(
                '${data[idx].value}',
                style: TextStyle(color: Color(0xff888888)),
              ),
            )
          ]);
        }));
  }
}
