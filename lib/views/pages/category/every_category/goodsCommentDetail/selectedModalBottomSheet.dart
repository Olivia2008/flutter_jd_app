import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:netease_news/components/customDropdownMenu/customDropdownMenuHeader.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';

class SelectedModal extends StatelessWidget {
  SelectedModal({this.selectedData});
  final Selected selectedData;

  String count = '';
  String selectedText = '';
  int _selectedColorIndex = 0;
  int _selectedStorageIndex = 1;
  int _selectedMethodsIndex = 0;
  int _selectedServiceIndex = -1;
  bool _selectedServiceBool = false;
  List _arr = [];
  TextEditingController countController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsCommentDetailProvide>(
      builder: (context, child, provider) {
        var selectedList = provider.selectedList;
        countController.text = '';
        selectedText =
            '${selectedList['color']}, ${selectedList['storage']}, ${selectedList['methods']}, ${selectedList['count']}件';
        return Container(
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
                    _colorWidget(selectedData, context, selectedList),
                    SizedBox(height: 10),
                    _storageWidget(selectedData, context, selectedList),
                    SizedBox(height: 10),
                    _methodsWidget(selectedData, context, selectedList),
                    _selectedMethodsIndex == 0
                        ? SizedBox(height: 10)
                        : SizedBox(height: 0),
                    _selectedMethodsIndex == 0
                        ? _matchWidget(selectedData, context)
                        : Container(),
                    SizedBox(height: 10),
                    _countWidget(selectedData, context, selectedList),
                    SizedBox(height: 10),
                    _serviceWidget(selectedData.service, context, selectedList),
                    SizedBox(height: ScreenUtil().setHeight(100)),
                  ],
                ),
                _selectedWidget(selectedData, context, selectedText),
                _buttonsWidget(context)
              ],
            ));
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

  Widget _colorWidget(data, context, selectedList) {
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
                selected: _selectedColorIndex == index,
                onSelected: (val) {
                  _selectedColorIndex = index;
                  selectedList['color'] = data.colors.colorList[index].label;
                  Provide.value<GoodsCommentDetailProvide>(context)
                      .getSelectedList(selectedList);
                },
              );
            }).toList(),
          ),
        ]));
  }

  Widget _storageWidget(data, context, selectedList) {
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
                    selected: _selectedStorageIndex == index,
                    onSelected: (val) {
                      _selectedStorageIndex = index;
                      selectedList['storage'] =
                          data.storage.versionList[index].label;
                      Provide.value<GoodsCommentDetailProvide>(context)
                          .getSelectedList(selectedList);
                    },
                  );
                }))
          ],
        ));
  }

  Widget _methodsWidget(data, context, selectedList) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(data.methods.title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0)),
        Wrap(
          spacing: 3,
          children: List.generate(data.methods.methodsList.length, (index) {
            return ChoiceChip(
                selected: _selectedMethodsIndex == index,
                onSelected: (val) {
                  _selectedMethodsIndex = index;
                  selectedList['methods'] =
                      data.methods.methodsList[index].label;
                  Provide.value<GoodsCommentDetailProvide>(context)
                      .getSelectedList(selectedList);
                },
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

  Widget _countWidget(data, context, selectedList) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data.count.title, style: TextStyle(fontWeight: FontWeight.w600)),
          Center(
            child: Container(
                height: ScreenUtil().setHeight(50),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          if (int.parse(selectedList['count']) > 1) {
                            selectedList['count'] =
                                (int.parse(selectedList['count']) - 1)
                                    .toString();
                            Provide.value<GoodsCommentDetailProvide>(context)
                                .getSelectedList(selectedList);
                          } else {
                            selectedList['count'] = '1';
                            Provide.value<GoodsCommentDetailProvide>(context)
                                .getSelectedList(selectedList);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 30,
                          child: Text(
                            '——',
                            style: TextStyle(fontSize: 24),
                          ),
                        )),
                    Container(
                      width: ScreenUtil().setWidth(200),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          filled: true,
                          fillColor: Color(0xfff2f2f7),
                          hintText: selectedList['count'],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none),
                        ),
                        textAlign: TextAlign.center,
                        controller: countController,
                        onChanged: (val) {
                          selectedList['count'] = val;
                          Provide.value<GoodsCommentDetailProvide>(context)
                              .getSelectedList(selectedList);
                        },
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          selectedList['count'] =
                              (int.parse(selectedList['count']) + 1).toString();
                          Provide.value<GoodsCommentDetailProvide>(context)
                              .getSelectedList(selectedList);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 30,
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 24),
                          ),
                        ))
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget _serviceWidget(data, context, selectedList) {
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
                        //     var _serviceList = List.generate(data[index].serviceList.length, (index) => {'idx': index}).toList();
                        // print(_serviceList);
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
                              Wrap(
                                spacing: 2,
                                children: List.generate(
                                    data[index]
                                        .serviceList[idx]
                                        .originList
                                        .length, (i) {
                                  return ChoiceChip(
                                    backgroundColor: Color(0xfff5f5f5),
                                    label: Text(
                                        '${data[index].serviceList[idx].originList[i].label} ￥${data[index].serviceList[idx].originList[i].price}.00'),
                                    labelPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    selected: _selectedServiceIndex == i,
                                    onSelected: (val) {
                                      _selectedServiceIndex = i;
                                      var j = data[index]
                                          .serviceList[idx]
                                          .originList[i];
                                      val
                                          ? selectedList['service'].add({
                                              'label': j.label,
                                              'price': j.price
                                            })
                                          : selectedList['service'].removeWhere(
                                              (j) =>
                                                  j ==
                                                  {
                                                    'label': j.label,
                                                    'price': j.price
                                                  });
                                      Provide.value<GoodsCommentDetailProvide>(
                                              context)
                                          .getSelectedList(selectedList);
                                    },
                                  );
                                }).toList(),
                              ),
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
