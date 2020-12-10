import 'package:flutter/material.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';
import 'package:netease_news/views/model/goods_accessory.dart';
import 'package:netease_news/views/model/goods_range.dart';
import 'package:netease_news/views/model/goods_rec.dart';
import 'package:netease_news/router/staticRouter.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/service/service_method.dart';
import 'dart:convert';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/tabBar.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/goodsIntroduce.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/goodsComments.dart';
import 'goodsCommentDetail/likeDetail.dart';
import './goodsCommentDetail/searchStickBar.dart';
import './goodsCommentDetail/goodsRecommend.dart';
import 'package:fluro/fluro.dart';
import 'package:netease_news/components/icons/myIcons.dart';

class GoodsCommentDetail extends StatefulWidget {
  GoodsCommentDetail(this.params);
  final Map<String, dynamic> params;
  @override
  _GoodsCommentDetailState createState() => _GoodsCommentDetailState();
}

class _GoodsCommentDetailState extends State<GoodsCommentDetail>
    with TickerProviderStateMixin {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  ScrollController _scrollController;
  TabController _outerTabController;
  String _videoUrl = '';
  bool _showTopBtn = false;
  double _screenHeight;
  // GoodsCommentDetailModel goodsInfo = null;
  double _topBarHeight = ScreenUtil().setHeight(440.0);
  bool _changeBar = false;
  // GoodsCommentDetailModel goodsCommentDetailInfo;
  AccessoryModel accessoryInfo;
  RangeModel rangeInfo;
  GoodsRecModel recommendInfo;
  Map searchInfo;
  int rangeTabLen = 1;
  int recTabLen = 1;
  List<Map> rangeList;
  List<Map> recommendList;
  bool _videoInitinalize = false;

  // 定义出autoInitial,当滚动到一定位置再设置为true

  // Future _getGoodsInfo(BuildContext context, goodsId) async {
  //   await Provide.value<GoodsCommentDetailProvide>(context)
  //       .getGoodsCommentDetail(goodsId);
  //   return 'goodsInfo的future数据加载完成......';
  // }

  Future _getGoodsInfo(BuildContext context, goodsId) async {
    var params = {'goodsId': goodsId};
    GoodsCommentDetailModel goodsCommentDetailInfo;
    await request('cateGoodsCommentDetail', params: params).then((value) {
      var data = json.decode(value.toString());
      goodsCommentDetailInfo = GoodsCommentDetailModel.fromJson(data);
      Provide.value<GoodsCommentDetailProvide>(context)
          .getGoodsInfo(goodsCommentDetailInfo);
      print('goodsInfo数据请求完成.................');

      var _goodsCommentDetailInfo =
          Provide.value<GoodsCommentDetailProvide>(context).goodsInfo;
      _videoUrl = _goodsCommentDetailInfo.data.result.introduce.vedio;
      var _videoImg = _goodsCommentDetailInfo.data.result.introduce.vedioImg;

      _videoPlayerController = VideoPlayerController.network(_videoUrl);
      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio: 16 / 9,
          autoPlay: false,
          autoInitialize: !_changeBar,
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
    });
    return 'aaa';
  }

  _getGoodsAccessory(String goodsId) async {
    var params = {'goodsId': goodsId};
    await request('goodsAccessory', params: params).then((value) {
      var data = json.decode(value.toString());
      accessoryInfo = AccessoryModel.fromJson(data);
      print('goods accessory数据请求完成.................');
    });
  }

  _getGoodsSearch(String goodsId) async {
    var params = {'goodsId': goodsId};
    await request('currentGoodsSearch', params: params).then((res) {
      var data = json.decode(res.toString());
      searchInfo = (data['data'] as Map).cast();
      print('goods current search数据请求完成.....................');
    });
  }

  _getGoodsRange(String goodsId) async {
    var params = {'goodsId': goodsId};
    await request('goodsRange', params: params).then((res) {
      var data = json.decode(res.toString());
      // cast 数据
      rangeList = (data['data']['listSkuRange'] as List).cast();
      rangeTabLen = rangeList.length != 0 ? (rangeList.length / 6).ceil() : 1;
      print(
          'goods range数据请求完成  rangeTabLen: $rangeTabLen.....................');
    });
  }

  _goodsLikeRec(String goodsId) async {
    var params = {'goodsId': goodsId};
    await request('goodsRecommend', params: params).then((res) {
      var data = json.decode(res.toString());
      // cast数据
      recommendList = (data['data']['listSkuRelation'] as List).cast();
      recTabLen =
          recommendList.length != 0 ? (recommendList.length / 6).ceil() : 1;
      print('goods recommends数据请求完成 recLen $recTabLen..............');
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
    _outerTabController = TabController(length: 2, vsync: this);

    // WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    // Future.delayed(Duration(milliseconds: 300)).then((value) {
    //   final RenderBox _introBox = _introKey.currentContext.findRenderObject();
    //   final _introOffset = _introBox.localToGlobal(Offset(0, 0));
    //   print('<<<<<<<<<<<<<商品positions: ${_introOffset.dy}');

    //   // 评价页面，详情页面不在第一页，此时页面还没有渲染出来，所以报错
    //   final RenderBox _comBox = _comKey.currentContext.findRenderObject();
    //   final _comOffset = _comBox.localToGlobal(Offset(0, 0));
    //   print('<<<<<<<<<<<<<<<<<<评价postions: {$_comOffset.dy}');

    //   final RenderBox _detailBox = _detailKey.currentContext.findRenderObject();
    //   final _detailOffset = _detailBox.localToGlobal(Offset(0, 0));
    //   print('<<<<<<<<<<<<<<<<<<<<<<<详情positions: {$_detailOffset.dy}');
    // });
    super.initState();
  }

  void _afterLayout(_) {
    _getPositions();
  }

  _getPositions() {
    final RenderBox _comBox = _comKey.currentContext.findRenderObject();
    final _comOffset = _comBox.localToGlobal(Offset(0, 0));
    print('<<<<<<<<<<<<<<<<<<评价postions: $_comOffset');

    final RenderBox _introBox = _introKey.currentContext.findRenderObject();
    final _introOffset = _introBox.localToGlobal(Offset(0, 0));
    print('<<<<<<<<<<<<<商品positions: $_introOffset');

    final RenderBox _detailBox = _detailKey.currentContext.findRenderObject();
    final _detailOffset = _detailBox.localToGlobal(Offset(0, 0));
    print('<<<<<<<<<<<<<<<<<<<<<<<详情positions: $_detailOffset');

    final RenderBox _recBox = _recKey.currentContext.findRenderObject();
    final _recOffset = _recBox.localToGlobal(Offset(0, 0));
    print('<<<<<<<<<<<<推荐positions: $_recOffset');
  }

  GlobalKey _introKey = GlobalKey();
  GlobalKey _comKey = GlobalKey();
  GlobalKey _detailKey = GlobalKey();
  GlobalKey _recKey = GlobalKey();

  void HandleScroll() {
    _screenHeight = MediaQuery.of(context).size.height;

    // 放在滚动中开始commentWidget 和detailWidget还没有渲染，滚动到一定位置两个组件渲染完成，才会打印出位置

    // final RenderBox _comBox = _comKey.currentContext.findRenderObject();
    // final _comOffset = _comBox.localToGlobal(Offset(0, 0));
    // print('<<<<<<<<<<<<<<<<<<评价postions: ${_comOffset.dy}');

    // final RenderBox _detailBox = _detailKey.currentContext.findRenderObject();
    // final _detailOffset = _detailBox.localToGlobal(Offset(0, 0));
    // print('<<<<<<<<<<<<<<<<<<<<<<<详情positions: ${_detailOffset.dy}');

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
    // 获取IntroduceWidget\CommentsWidget\RecommendWidget position,

    // print(
    //     'scroll offset:${_scrollController.offset},screenHeight:${ScreenUtil().setHeight(1666)}');
    print('scroll offset:${_scrollController.offset}>>>>>>>>>>>>');
    if (_scrollController.offset >= ScreenUtil().setHeight(1666) &&
        _scrollController.offset < ScreenUtil().setHeight(4900)) {
      Provide.value<GoodsCommentDetailProvide>(context).changeTabIndex(1);
    } else if (_scrollController.offset >= ScreenUtil().setHeight(4900) &&
        _scrollController.offset < ScreenUtil().setHeight(18000)) {
      Provide.value<GoodsCommentDetailProvide>(context).changeTabIndex(2);
      // Provide.value<GoodsCommentDetailProvide>(context).changeVideoInit(true);
    } else if (_scrollController.offset >= ScreenUtil().setHeight(18100)) {
      Provide.value<GoodsCommentDetailProvide>(context).changeTabIndex(3);
      // Provide.value<GoodsCommentDetailProvide>(context).changeVideoInit(false);
    } else if (_scrollController.offset < ScreenUtil().setHeight(1666)) {
      Provide.value<GoodsCommentDetailProvide>(context).changeTabIndex(0);
    }

    if (_scrollController.offset >= ScreenUtil().setHeight(3000)) {
      Provide.value<GoodsCommentDetailProvide>(context).changeVideoInit(true);
    } else {
      Provide.value<GoodsCommentDetailProvide>(context).changeVideoInit(false);
    }

    // scroll在topBarHeight内显示背景透明度动画
    if (_scrollController.offset >= 50) {
      if (!mounted) return;
      setState(() {
        _changeBar = true;
      });
    } else {
      if (!mounted) return;
      setState(() {
        _changeBar = false;
      });
    }
  }

  @override
  void dispose() {
    print('生命周期dispose>>>>>>>>>>');
    _videoPlayerController.dispose();
    _chewieController.dispose();
    _scrollController?.dispose();
    _outerTabController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(GoodsCommentDetail oldWidget) {
    print('生命周期didUpadteWidget>>>>>>>>>>');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    print('生命周期didChangeDependencies>>>>>>>>>>');
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        floatingActionButton:
            _showTopBtn ? _floatingActionButton(context) : null,
        body: FutureBuilder(
            future: _getGoodsInfo(context, widget.params['goodsId'].first),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var _goodsCommentDetailInfo =
                    Provide.value<GoodsCommentDetailProvide>(context).goodsInfo;
                return Stack(
                  children: [
                    CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverAppBar(
                            backgroundColor: Color(0xffffffff),
                            leading: IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: _changeBar
                                        ? Color(0xff333333)
                                        : Color(0xffffffff)),
                                onPressed: () {
                                  StaticRouter.router.navigateTo(context,
                                      '/categoryDetails?pareId=1&subId=1&categoryId=10001',
                                      transition: TransitionType.fadeIn);
                                }),
                            actions: [
                              Icon(Icons.share,
                                  color: _changeBar
                                      ? Color(0xff333333)
                                      : Color(0xffffffff)),
                              Padding(
                                  padding:
                                      EdgeInsets.only(right: 20.0, left: 10.0),
                                  child: Icon(Icons.more_horiz,
                                      color: _changeBar
                                          ? Color(0xff333333)
                                          : Color(0xffffffff)))
                            ],
                            title: _changeBar
                                ? TabBarWidget(_scrollController)
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
                                    ])))),
                        SliverList(
                            delegate: SliverChildListDelegate(<Widget>[
                          IntroduceWidget(_goodsCommentDetailInfo, _introKey),
                          CommentsWidget(
                              _goodsCommentDetailInfo, accessoryInfo, _comKey)
                        ])),
                        SearchStickyBar(
                          searchInfo,
                          widget.params,
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            // height: ScreenUtil().setHeight(1600),
                            child: Column(
                              children: [
                                GoodsDetailWidget(
                                    _detailKey,
                                    searchInfo,
                                    recommendList,
                                    rangeList,
                                    _outerTabController),
                                GoodsRecommentWidget(recommendList)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                            width: ScreenUtil().setWidth(750),
                            height: ScreenUtil().setHeight(100),
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 6, right: 6),
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                    Icon(MyIcons.store, size: 24),
                                    Text('店铺',
                                        style: TextStyle(
                                          fontSize: 10,
                                            color: Color(0xff888888))),
                                  ])),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                    Icon(MyIcons.wechat, size: 24),
                                    Text('客服',
                                        style: TextStyle(
                                          fontSize: 10,
                                            color: Color(0xff888888))),
                                  ])),
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Container(
                                      // padding: EdgeInsets.only(top: 8),
                                      child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: ScreenUtil().setWidth(100),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(top: 8),
                                              child: Icon(MyIcons.cart, size: 24, color: Color(0xff333333)),),
                                          Positioned(
                                              top: 4,
                                              right: 6,
                                              child: Container(
                                                  padding: EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 1.0),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffffffff),
                                                      border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0)),
                                                  child: Text('1',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                          color: Theme.of(context)
                                                              .primaryColor))))
                                        ],
                                      ),
                                      Text('购物车',
                                          style: TextStyle(
                                            fontSize: 10,
                                              color: Color(0xff888888))),
                                    ])
                                    )),
                                Container(
                                  padding: EdgeInsets.only(top: 6),
                                  child: FlatButton(
                                  color: Color(0xfff2140c),
                                  textColor: Color(0xffffffff),
                                  child: Text('加入购物车'),
                                  onPressed: () {
                                    print('加入购物车');
                                  },
                                )
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 6),
                                  child: FlatButton(
                                  color: Color(0xffffba0d),
                                  textColor: Color(0xffffffff),
                                  child: Text('立即购买'),
                                  onPressed: () {
                                    print('立即购买');
                                  },
                                ),
                                )
                              ],
                            )))
                  ],
                );
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
              duration: Duration(milliseconds: 200), curve: Curves.ease);
        },
        child: Icon(Icons.arrow_upward));
  }
}
