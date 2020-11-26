
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';

class SelectedModal extends StatefulWidget {
  SelectedModal({this.data});
  final Selected data;
  @override
  _SelectedModalState createState() => _SelectedModalState();
}

class _SelectedModalState extends State<SelectedModal> {
  TextEditingController countController = TextEditingController();
  String count = '';
  @override
  void initState() {
    // TODO: implement initState
    // countController = TextEditingController.fromValue(value: '1');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedText = '';
    return Provide<GoodsCommentDetailProvide>(
      builder: (context, child, provider) {
          return provider.selectedList != null ? Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
            color: Color(0xffffffff)),
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: ScreenUtil().setHeight(180)),
                _colorWidget(widget.data, context),
                SizedBox(height: 10),
                _storageWidget(widget.data, context),
                SizedBox(height: 10),
                _methodsWidget(widget.data, context),
                SizedBox(height: 10),
                _matchWidget(widget.data, context),
                SizedBox(height: 10),
                _countWidget(widget.data, context),
                SizedBox(height: 10),
                _serviceWidget(widget.data.service, context),
                SizedBox(height: ScreenUtil().setHeight(100)),
              ],
            ),
            _selectedWidget(widget.data, context, selectedText),
            _buttonsWidget(context)
          ],
        )) : Container();
        
      },
    );
  }

  Widget _selectedWidget(data, context, selectedText) {
    return Positioned(
      top: 0,
      child: Container(
        height: ScreenUtil().setHeight(180),
        width: ScreenUtil().setWidth(666),
        color: Color(0xffffffff),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Flexible(
                flex: 1,
                child: Container(
                    width: ScreenUtil().setWidth(200),
                    height: ScreenUtil().setHeight(150),
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/lazy.png',
                        image: data.img,
                        fit: BoxFit.fill))),
            Container(
                child: Column(
              children: [
                Text.rich(TextSpan(
                    text: '￥',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 12.0),
                    children: [
                      TextSpan(
                        text: data.price,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.0),
                      ),
                      TextSpan(
                          text: '.00',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12.0))
                    ])),
                Chip(
                    label: Text(
                      '已选: $selectedText',
                      style: TextStyle(fontSize: 12, color: Color(0xff888888)),
                    ),
                    backgroundColor: Color(0xfff5f5f5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)))
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _colorWidget(data, context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '外观(${data.colors.colorList.length})',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 5,
            children: List.generate(data.colors.colorList.length, (index) {
              return ChoiceChip(
                backgroundColor: Color(0xfff5f5f5),
                label: Text(data.colors.colorList[index].label),
                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                selected: false,
                onSelected: (val) {
                  print(val);
                },
              );
            }),
          ),
        ]));
  }

  Widget _storageWidget(data, context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.storage.title,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600)),
            Wrap(
                spacing: 3,
                children:
                    List.generate(data.storage.versionList.length, (index) {
                  return ChoiceChip(
                    backgroundColor: Color(0xfff5f5f5),
                    label: Text(data.storage.versionList[index].label),
                    labelPadding: EdgeInsets.symmetric(horizontal: 10),
                    selected: false,
                    onSelected: (val) {},
                  );
                }))
          ],
        ));
  }

  Widget _methodsWidget(data, context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(data.methods.title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0)),
        Wrap(
          spacing: 3,
          children: List.generate(data.methods.methodsList.length, (index) {
            return ChoiceChip(
                selected: false,
                onSelected: (val) {},
                backgroundColor: Color(0xfff5f5f5),
                label: Text(data.methods.methodsList[index].label),
                labelPadding: EdgeInsets.symmetric(horizontal: 10));
          }),
        )
      ]),
    );
  }

  Widget _matchWidget(data, context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.standMatch.title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0)),
            ChoiceChip(
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              backgroundColor: Color(0xfff5f5f5),
              label: Text(data.standMatch.matchList[0].label),
              selected: true,
              onSelected: (val) {},
            )
          ],
        ));
  }

  Widget _countWidget(data, context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data.count.title,
              style: TextStyle(fontWeight: FontWeight.w600)),
          Center(
            child: Container(
            height: ScreenUtil().setHeight(50),
            alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.minimize),
                onPressed: () {print('min');},
              ),
              Container(
                width: ScreenUtil().setWidth(200),
                child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical:0.0),
                filled: true,
                fillColor: Color(0xfff2f2f7),
                hintText: '1',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none),),
                textAlign: TextAlign.center,
                controller: countController,
                onChanged: (val) {
                  setState(() {
                    count = val;
                  });
                },
              ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {print('add');},
              )
            ],
          )),
          )
          
        ],
      ),
    );
  }

  Widget _serviceWidget(data, context) {
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(data.length, (index) {
              return Container(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index].title,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w600)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          List.generate(data[index].serviceList.length, (idx) {
                        return Container(
                          padding: EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      verticalDirection: VerticalDirection.up,
                                      children: [
                                        Icon(
                                          Icons.local_laundry_service,
                                          size: 14,
                                          color: Color(0xff409eff),
                                        ),
                                        Text(data[index].serviceList[idx].label)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      verticalDirection: VerticalDirection.up,
                                      children: [
                                        Text(data[index].serviceList[idx].more,
                                            style: TextStyle(
                                                color: Color(0xff888888))),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Icon(Icons.arrow_forward_ios,
                                              color: Color(0xff888888),
                                              size: 10),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Card(
                                elevation: 0,
                                color: Color(0xfff5f5f5),
                                margin: EdgeInsets.only(top: 10),
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                        children: List.generate(
                                            data[index]
                                                .serviceList[idx]
                                                .originList
                                                .length, (i) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        verticalDirection:
                                            VerticalDirection.up,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              verticalDirection:
                                                  VerticalDirection.up,
                                              children: [
                                                Transform(
                                                  transform: Matrix4.identity()
                                                    ..scale(0.8),
                                                  child: Checkbox(
                                                      value: true,
                                                      onChanged: (val) {}),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      data[index]
                                                              .serviceList[idx]
                                                              .originList[i]
                                                              .icon != '' ? Text('${data[index]
                                                              .serviceList[idx]
                                                              .originList[i]
                                                              .label}(${data[index]
                                                              .serviceList[idx]
                                                              .originList[i]
                                                              .icon})') : Text(data[index]
                                                              .serviceList[idx]
                                                              .originList[i]
                                                              .label),
                                                      Text(
                                                          data[index]
                                                              .serviceList[idx]
                                                              .originList[i]
                                                              .dis,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff888888)))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                              '￥${data[index].serviceList[idx].originList[i].price}.00',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor))
                                        ],
                                      );
                                    }))),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              );
            })));
  }

  Widget _buttonsWidget(context) {
    return Positioned(
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          height: ScreenUtil().setHeight(100),
          padding: EdgeInsets.symmetric(vertical: 10),
          color: Color(0xffffffff),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                color: Color(0xfff2140c),
                textColor: Color(0xffffffff),
                child: Text('加入购物车'),
                onPressed: () {
                  print('加入购物车');
                },
              ),
              FlatButton(
                color: Color(0xffffba0d),
                textColor: Color(0xffffffff),
                child: Text('立即购买'),
                onPressed: () {
                  print('立即购买');
                },
              )
            ],
          ),
        ));
  }
}
