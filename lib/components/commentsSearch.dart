import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_news/views/model/goods_search.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';

class CustomCommentsSearch extends StatefulWidget {
  CustomCommentsSearch({@required this.goodsId});
  final String goodsId;
  @override
  _CustomCommentsSearchState createState() => _CustomCommentsSearchState();
}

class _CustomCommentsSearchState extends State<CustomCommentsSearch> {
  GoodsRecommendSearchModel searchInfo;
  String searchValue = "";
  TextEditingController _controller = TextEditingController();
  List<History> historyArr;
  bool deleteConfirm = false;
  String _hintText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _getHintSearchData(String goodsId) async {
    List hintData = [];
    await request('goodsHint', params: {'goodsId': goodsId}).then((res) {
      var data = json.decode(res.toString());
      hintData = (data['result']['hintList'] as List).cast();
      print('goods hint search 数据请求完成.....................');
    });
    return hintData;
  }

  Future _getGoodsSearch(String goodsId) async {
    var params = {'goodsId': goodsId};
    await request('goodsSearch', params: params).then((res) {
      var data = json.decode(res.toString());
      searchInfo = GoodsRecommendSearchModel.fromJson(data);
      // historyArr = searchInfo.data.history;
      _hintText = searchInfo.data.selected.name;
      print('goods search数据请求完成.....................');
    });
    return searchInfo;
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = '${searchValue == null ? '' : searchValue}';
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: searchValue.length));
    return FutureBuilder(
        future: _getGoodsSearch(widget.goodsId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            deleteConfirm
                ? historyArr = []
                : historyArr = snapshot.data.data.history;

            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xffff627c), Color(0xffff0d0d)],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [0.2, 1]))),
                title: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        child: Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 16),
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(36)),
                          child: TextField(
                            autofocus: true,
                            controller: _controller,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search,
                                    color: Color(0xff888888), size: 16),
                                hintText: '${snapshot.data.data.selected.name}',
                                border: InputBorder.none,
                                suffixIcon: searchValue == ''
                                    ? Icon(Icons.camera_alt,
                                        color: Color(0xff888888), size: 16)
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            searchValue = '';
                                          });
                                        },
                                        child: Icon(Icons.close,
                                            color: Color(0xff888888), size: 16),
                                      )),
                            style: TextStyle(fontSize: 12),
                            onChanged: (value) {
                              setState(() {
                                searchValue = value;
                              });
                            },
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
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              backgroundColor: Color(0xfff5f5f5),
              body: SingleChildScrollView(
                  child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                behavior: HitTestBehavior.translucent,
                child: searchValue == ''
                    ? getHistoryConnectionWidget(context, snapshot.data.data)
                    : getHintSearchWidget(context),
              )),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget getHistoryConnectionWidget(context, data) {
    return Container(
        padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
        child: Column(
          children: [
            getConnectWidget(context, data.connection),
            SizedBox(height: 10),
            deleteConfirm
                ? Container()
                : getSearchHistoryWidget(context, historyArr)
          ],
        ));
  }

// hint search
  Widget getHintSearchWidget(context) {
    return FutureBuilder(
        future: _getHintSearchData(widget.goodsId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map> _results = [];
            List.generate(snapshot.data.length, (index) {
              if (snapshot.data[index]['name'].contains(searchValue)) {
                _results.add(snapshot.data[index]);
              }
            });
            return _results.length != 0
                ? Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0))),
                    child: Column(
                      children: List.generate(_results.length, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              searchValue = _results[index]['name'];
                            });
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xfff2f2f2)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(_results[index]['name']),
                                ),
                                _results[index]['subList'].length != 0
                                    ? Wrap(
                                        spacing: 6.0,
                                        runSpacing: 6.0,
                                        children: List.generate(
                                            _results[index]['subList'].length,
                                            (idx) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                searchValue =
                                                    '${_results[index]['name']} ${_results[index]['subList'][idx]}';
                                              });
                                            },
                                            child: Chip(
                                              backgroundColor:
                                                  Color(0xfff2f2f2),
                                              label: Text(
                                                  _results[index]['subList']
                                                      [idx],
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                            ),
                                          );
                                        }))
                                    : Container()
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                : Center(
                    child: Text('暂无搜索数据!'),
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
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
        Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: List.generate(data.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    searchValue = data[index].name;
                  });
                },
                child: Chip(
                  backgroundColor: Color(0xfff2f2f2),
                  label: Text(data[index].name, style: TextStyle(fontSize: 12)),
                ),
              );
            }))
      ],
    );
  }

// search history
  Widget getSearchHistoryWidget(context, data) {
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
        Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(data.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    searchValue = data[index].name;
                  });
                },
                child: Chip(
                  backgroundColor: Color(0xfff2f2f2),
                  label: Text(data[index].name, style: TextStyle(fontSize: 12)),
                ),
              );
            }))
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
