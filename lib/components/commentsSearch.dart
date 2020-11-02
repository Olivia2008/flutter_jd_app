import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_news/views/model/goods_search.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';

class CustomCommentsSearch extends StatefulWidget {
  CustomCommentsSearch({@required this.goodsId});
  final String goodsId;

  List<String> contents = [
    "mc20",
    "sony A6300系列",
    "sony a7",
    "sony 黑卡",
    "iphone xr",
    "'耐克'店铺",
    "mc20",
    "123",
    "321"
  ];

  List<String> hisArray = [
    "mc20",
    "sony A6300系列",
    "iphone xr",
    "'耐克'店铺",
    "mc20",
  ];

  @override
  _CustomCommentsSearchState createState() => _CustomCommentsSearchState();
}

class _CustomCommentsSearchState extends State<CustomCommentsSearch> {
  GoodsRecommendSearchModel searchInfo;
  String searchValue = "";
  TextEditingController _controller = TextEditingController();
  List<History> historyArr;
  bool deleteConfirm = false;
  @override
  void initState() {
    // print('custom comment search goodsId:${widget.goodsId}');
    // _getGoodsSearch(widget.goodsId);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _getGoodsSearch(String goodsId) async {
    var params = {'goodsId': goodsId};
    await request('goodsSearch', params: params).then((res) {
      var data = json.decode(res.toString());
      searchInfo = GoodsRecommendSearchModel.fromJson(data);
      // historyArr = searchInfo.data.history;
      print('goods search数据请求完成.....................');
    });
    return searchInfo;
  }

  @override
  Widget build(BuildContext context) {
    double statusHeight = MediaQuery.of(context).padding.top;
    _controller.text = searchValue;
    return Scaffold(
        body: FutureBuilder(
      future: _getGoodsSearch(widget.goodsId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('custom search ${snapshot.data.data.connection}');
          deleteConfirm ? historyArr = [] : historyArr = snapshot.data.data.history;
          return Container(
            // padding: EdgeInsets.fromLTRB(16, 0, 0, 16),
            child: Column(
              children: [
                Container(
                  height: 48 + statusHeight,
                  padding: EdgeInsets.fromLTRB(12, 3 + statusHeight, 12, 3),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffff627c), Color(0xffff0d0d)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          stops: [0.2, 1])),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 16),
                        ),
                      ),
                      // SizedBox(width: 12),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(36)),
                            child: Row(
                              children: [
                                SizedBox(width: 6),
                                Icon(Icons.search,
                                    color: Color(0xff888888), size: 16),
                                SizedBox(width: 6),
                                Expanded(
                                    flex: 1,
                                    child: TextField(
                                      controller: _controller,
                                      decoration: InputDecoration(
                                        hintText:
                                            '${snapshot.data.data.selected.name}',
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(fontSize: 12),
                                      onChanged: (value) {
                                        setState(() {
                                          searchValue = value;
                                        });
                                        _controller.text = searchValue;
                                      },
                                    )),
                                Icon(Icons.camera_alt,
                                    color: Color(0xff888888), size: 16),
                                SizedBox(width: 3),
                                searchValue != ''
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            searchValue = '';
                                          });
                                        },
                                        child: Icon(Icons.close, size: 14),
                                      )
                                    : Container(),
                                SizedBox(width: 6)
                              ],
                            ),
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.pop(context);
                        },
                        child: Text(
                          '搜索',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                searchValue == '' ? getHistoryConnectionWidget(context, snapshot.data.data) : getHintSearchWidget()
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Widget getHistoryConnectionWidget(context, data) {
    return Container(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Column(
          children: [getConnectWidget(context, data.connection), deleteConfirm ? Container() : getSearchHistoryWidget(context, historyArr)],
        ));
  }

// hint search
  Widget getHintSearchWidget() {
    List<String> results = [];
    List.generate(widget.contents.length, (index) {
      if (widget.contents[index].contains(searchValue)) {
        results.add(widget.contents[index]);
      }
    });
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        children: List.generate(results.length, (index) {
          return InkWell(
            onTap: () {
              _controller.text = results[index];
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xfff2f2f2)))),
              child: Text(results[index]),
            ),
          );
        }),
      ),
    );
  }

// connect
  Widget getConnectWidget(context, data) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '相关商品',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        SingleChildScrollView(
            child: Wrap(spacing: 6.0, runSpacing: 6.0, children: List.generate(data.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    searchValue = data[index].name;
                  });
                },
                child: Chip(
                      backgroundColor: Color(0xfff2f2f2),
                      label: Text(data[index].name,
                          style: TextStyle(fontSize: 12)),
                    ),
              );
            })))
      ],
    );
  }

// search history
  Widget getSearchHistoryWidget(context, data) {
    print('初始时historyArr:${data.length}');
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('搜索历史', style: TextStyle(fontWeight: FontWeight.bold)),
              InkWell(
                  onTap: showClearDialog,
                  child: Icon(Icons.delete_forever,
                      color: Colors.redAccent, size: 20))
            ],
          ),
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
            child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children:
                    List.generate(data.length, (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        searchValue = data[index].name;
                      });
                    },
                    child: Chip(
                      backgroundColor: Color(0xfff2f2f2),
                      label: Text(data[index].name,
                          style: TextStyle(fontSize: 12)),
                    ),
                  );
                })))
      ],
    );
  }

  showClearDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(''),
            content: Text('确认清除所有搜索记录吗？'),
            actions: [
              ActionChip(
                  label: Text('取消'),
                  onPressed: () {
                    Navigator.pop(context);
                    print('取消');
                  }),
              ActionChip(
                  label: Text('确定'),
                  onPressed: () {
                    setState(() {
                      deleteConfirm = true;
                    });
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
