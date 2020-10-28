import 'package:flutter/material.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';
import 'package:netease_news/views/model/goods_accessory.dart';
import 'package:netease_news/views/model/goods_range.dart';
import 'package:netease_news/views/model/goods_rec.dart';
import 'package:netease_news/views/model/goods_search.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';
import 'dart:math';
// import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/tabBar.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/tabTarWidget.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/goodsIntroduce.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/goodsComments.dart';
import 'goodsCommentDetail/recommend.dart';
// import 'package:netease_news/components/stickBar/sliverSearchAppBar.dart';

class GoodsCommentDetail extends StatefulWidget {
  GoodsCommentDetail(this.params);
  final Map<String, dynamic> params;
  @override
  _GoodsCommentDetailState createState() => _GoodsCommentDetailState();
}

class _GoodsCommentDetailState extends State<GoodsCommentDetail>
    with SingleTickerProviderStateMixin {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  ScrollController _scrollController;
  TabController _tabController;
  String _videoUrl = '';
  bool _showTopBtn = false;
  double _screenHeight;
  // GoodsCommentDetailModel goodsInfo = null;
  double _topBarHeight = ScreenUtil().setHeight(440.0);
  bool _changeBar = false;
  GoodsCommentDetailModel goodsCommentDetailInfo;
  AccessoryModel accessoryInfo;
  RangeModel rangeInfo;
  GoodsRecModel recommendInfo;
  GoodsRecommendSearchModel searchInfo;

  Future _getGoodsInfo(BuildContext context, goodsId) async {
    var params = {'goodsId': goodsId};
    await request('cateGoodsCommentDetail', params: params).then((value) {
      var data = json.decode(value.toString());
      goodsCommentDetailInfo = GoodsCommentDetailModel.fromJson(data);
      // print('goodsInfo数据请求完成 ${data['data']['result']['comments']} .............');
    });
    return goodsCommentDetailInfo;
  }

  _getGoodsAccessory(String goodsId) async{
    var params = {'goodsId': goodsId};
    await request('goodsAccessory', params: params).then((value) {
      var data = json.decode(value.toString());
      accessoryInfo = AccessoryModel.fromJson(data);
      print('goods accessory数据请求完成.................');
    });
  }

  _getGoodsSearch(String goodsId) async {
    var params = {'goodsId': goodsId};
    await request('goodsSearch', params: params).then((res) {
      var data = json.decode(res.toString());
      searchInfo = GoodsRecommendSearchModel.fromJson(data);
      print('goods search数据请求完成.....................');
    });
  }

  _getGoodsRange(String goodsId) async {
    var params = {'goodsId': goodsId};
    await request('goodsRange', params: params).then((res) {
      var data = json.decode(res.toString());
      rangeInfo = RangeModel.fromJson(data);
      print('goods range数据请求完成.....................');
    });
  }

  _goodsLikeRec(String goodsId) async {
    var params = {'goodsId': goodsId};
    await request('goodsRecommend', params: params).then((res) {
      var data = json.decode(res.toString());
      recommendInfo = GoodsRecModel.fromJson(data);
      print('goods recommends数据请求完成..............');
    });
  }

  @override
  void initState() {
    _getGoodsAccessory(widget.params['goodsId'].first);
    _getGoodsSearch(widget.params['goodsId'].first);
    _getGoodsRange(widget.params['goodsId'].first);
    _goodsLikeRec(widget.params['goodsId'].first);
    _scrollController = new ScrollController();
    _scrollController.addListener(HandleScroll);
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  void HandleScroll() {
    _screenHeight = MediaQuery.of(context).size.height;

    // 超过一屏显示backTopIcon
    if (_scrollController.offset < _screenHeight && _showTopBtn) {
      setState(() {
        _showTopBtn = false;
      });
    } else if (_scrollController.offset >= _screenHeight &&
        _showTopBtn == false) {
      setState(() {
        _showTopBtn = true;
      });
    }
    // 监听滚动高度切换tab
    // print(
    //     'scroll offset:${_scrollController.offset},screenHeight:${ScreenUtil().setHeight(1583)}');
    // if (_scrollController.offset >= ScreenUtil().setHeight(1583)) {
    //   Provide.value<GoodsCommentDetailProvide>(context).changeTabIndex(1);
    // } else {
    //   Provide.value<GoodsCommentDetailProvide>(context).changeTabIndex(0);
    // }
    
    // scroll在topBarHeight内显示背景透明度动画
    if (_scrollController.offset >= 50) {
      setState(() {
        _changeBar = true;
      });
    } else {
      setState(() {
        _changeBar = false;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _scrollController?.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(GoodsCommentDetail oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        floatingActionButton: _showTopBtn
            ? _floatingActionButton(context)
            : null,
        body: FutureBuilder(
            future: _getGoodsInfo(context, widget.params['goodsId'].first),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print('introduce snapshot data:${snapshot.data}');
                _videoUrl = goodsCommentDetailInfo.data.result.introduce.vedio;
                var _videoImg =
                    goodsCommentDetailInfo.data.result.introduce.vedioImg;
                _videoPlayerController =
                    VideoPlayerController.network(_videoUrl);
                _chewieController = ChewieController(
                    videoPlayerController: _videoPlayerController,
                    aspectRatio: 16 / 9,
                    autoPlay: false,
                    looping: true,
                    placeholder: Container(
                        alignment: Alignment.center,
                        child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/lazy.png',
                            image: _videoImg,
                            width: ScreenUtil().setWidth(750),
                            height: ScreenUtil().setHeight(440),
                            fit: BoxFit.fill)),
                    materialProgressColors: ChewieProgressColors(
                      playedColor: Color(0xffff9999),
                      handleColor: Color(0xff000000),
                      backgroundColor: Color(0xff999999),
                      bufferedColor: Color(0xffe0e0e0),
                    ));
                    return NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (BuildContext context, bool boo) {
                        return <Widget>[
                          SliverAppBar(
                        backgroundColor: Color(0xffffffff),
                        leading: IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                color: _changeBar
                                    ? Color(0xff333333)
                                    : Color(0xffffffff)),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        actions: [
                          Icon(Icons.share,
                              color: _changeBar
                                  ? Color(0xff333333)
                                  : Color(0xffffffff)),
                          Padding(
                              padding: EdgeInsets.only(right: 20.0, left: 10.0),
                              child: Icon(Icons.more_horiz,
                                  color: _changeBar
                                      ? Color(0xff333333)
                                      : Color(0xffffffff)))
                        ],
                        title: _changeBar
                            ? TabBarWidget(tabController: _tabController,)
                            : IconButton(
                                color: Color(0xffffffff),
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  print('colse button');
                                },
                              ),
                        expandedHeight: _topBarHeight,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                                width: ScreenUtil().setWidth(750),
                                height: _topBarHeight,
                                color: Color(0xff000000),
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(160)),
                                alignment: Alignment.center,
                                child: Column(children: <Widget>[
                                  Chewie(
                                    controller: _chewieController,
                                  )
                                ]))))
                        ];
                      },
                      body: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          IntroduceWidget(goodsCommentDetailInfo),
                          CommentsWidget(goodsCommentDetailInfo, accessoryInfo),
                          RecommendWidget(searchInfo, recommendInfo, rangeInfo),
                          Container(
                            height: ScreenUtil().setHeight(300),
                            child: Text('推荐')
                          )
                        ]),
                    );
                // return CustomScrollView(
                //   controller: _scrollController,
                //   slivers: [
                //     SliverAppBar(
                //         backgroundColor: Color(0xffffffff),
                //         leading: IconButton(
                //             icon: Icon(Icons.arrow_back_ios,
                //                 color: _changeBar
                //                     ? Color(0xff333333)
                //                     : Color(0xffffffff)),
                //             onPressed: () {
                //               Navigator.pop(context);
                //             }),
                //         actions: [
                //           Icon(Icons.share,
                //               color: _changeBar
                //                   ? Color(0xff333333)
                //                   : Color(0xffffffff)),
                //           Padding(
                //               padding: EdgeInsets.only(right: 20.0, left: 10.0),
                //               child: Icon(Icons.more_horiz,
                //                   color: _changeBar
                //                       ? Color(0xff333333)
                //                       : Color(0xffffffff)))
                //         ],
                //         title: _changeBar
                //             ? TabBarWidget(_scrollController)
                //             : IconButton(
                //                 color: Color(0xffffffff),
                //                 icon: Icon(Icons.close),
                //                 onPressed: () {
                //                   print('colse button');
                //                 },
                //               ),
                //         expandedHeight: _topBarHeight,
                //         pinned: true,
                //         flexibleSpace: FlexibleSpaceBar(
                //             background: Container(
                //                 width: ScreenUtil().setWidth(750),
                //                 height: _topBarHeight,
                //                 color: Color(0xff000000),
                //                 padding: EdgeInsets.only(
                //                     top: ScreenUtil().setHeight(160)),
                //                 alignment: Alignment.center,
                //                 child: Column(children: <Widget>[
                //                   Chewie(
                //                     controller: _chewieController,
                //                   )
                //                 ])))),
                //     SliverList(
                //         delegate: SliverChildListDelegate(<Widget>[
                //       IntroduceWidget(goodsCommentDetailInfo), // height: 1740
                //       CommentsWidget(goodsCommentDetailInfo, accessoryInfo),
                //       RecommendWidget(searchInfo, recommendInfo, rangeInfo)
                //     ])),
                //     // _buildSearchStickyBar(context, searchInfo),
                //     // SliverList(delegate: SliverChildListDelegate(<Widget>[
                //     //   RecommendWidget(searchInfo, recommendInfo, rangeInfo)
                //     // ]))
                //   ],
                // );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget _floatingActionButton(context) {
    return FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  _scrollController.animateTo(0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                },
                child: Icon(Icons.arrow_upward));
  }

  Widget _buildSearchStickyBar(context, data) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: _SliverAppBarDelegate(
        maxHeight: 28,
        minHeight: 28,
        child: Container(
        width: ScreenUtil().setWidth(666),
        child: Row(
              children: [
                InputChip(
                  padding: EdgeInsets.only(left: 6.0, right: 6.0),
                  label: Text(
                    '苹果                                        ',
                    style: TextStyle(color: Color(0xffeeeeee), fontSize: 14),
                  ),
                  avatar: Icon(
                    Icons.search,
                    color: Color(0xff666666),
                    size: 16
                  ),
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('搜索'),
                )
              ],
            ),)
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}


