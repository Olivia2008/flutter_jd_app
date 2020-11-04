import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:netease_news/router/staticRouter.dart';

class SearchResultDetail extends StatefulWidget {
  SearchResultDetail({@required this.searchId});
  final String searchId;
  @override
  _SearchResultDetailState createState() => _SearchResultDetailState();
}

class _SearchResultDetailState extends State<SearchResultDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff5f5f5),
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
                title: Container(
                  child: Row(
                    children: [
                      InkWell(
                      onTap: () {
                        var _goodsId = widget.searchId.split('_').sublist(0, 4).join('_');
                        StaticRouter.router.navigateTo(context, '/cateGoodsDetail?goodsId=$_goodsId', transition: TransitionType.fadeIn,);
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
                      child: InkWell(
                        onTap: () {
                          print('parent chip on tap');
                          var _goodsId = widget.searchId.split('_').sublist(0, 4).join('_');
                          StaticRouter.router.navigateTo(context, '/cateGoodsDetail/goodsSearch?goodsId=$_goodsId');
                        },
                        child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0,),
                        height: 32,
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                              borderRadius: BorderRadius.circular(36)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform(
                              alignment: Alignment.centerLeft,
                              transform: Matrix4.identity()..scale(0.8),
                              child: InputChip(
                                backgroundColor: Color(0xff888888),
                                onPressed: () {
                                  print('chip press');
                                  var _goodsId = widget.searchId.split('_').sublist(0, 4).join('_');
                                  StaticRouter.router.navigateTo(context, '/cateGoodsDetail/goodsSearch?goodsId=$_goodsId');
                                },
                                onDeleted: () {},
                                deleteIcon: Icon(Icons.close, size: 14),
                                deleteIconColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.white,),
                                label: Text('${Provide.value<GoodsCommentDetailProvide>(context).searchResultText}'),
                              )
                            ),
                            Icon(Icons.camera_alt, size: 16, color: Color(0xff888888),)
                          ],
                        ),
                      ),
                      ),
                    ),
                    SizedBox(width: 8.0,),
                    Icon(Icons.category, size: 16, color: Colors.white,)
                    ],
                  ),
                ),),
      body: SingleChildScrollView(
        child: Center(child: Text('暂无数据')),
      )
    );
  }
}