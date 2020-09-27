import 'package:flutter/material.dart';
import 'package:netease_news/views/provides/goods/comment_detail.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_news/views/model/goods_comment_detail.dart';
import 'package:provide/provide.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/tabBar.dart';
import 'package:netease_news/views/pages/category/every_category/goodsCommentDetail/goodsIntroduce.dart';

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
  String _videoUrl = '';
  bool _showTopBtn = false;
  double _screenHeight;
  GoodsCommentDetailModel goodsInfo = null;
  double _topBarHeight = ScreenUtil().setHeight(600.0);
  bool _changeBar = false;

  Future getGoodsInfo(BuildContext context) async {
    await Provide.value<GoodsCommentDetailProvide>(context)
        .getGoodsCommentDetail(widget.params['goodsId'].first);
    return 'goodsInfo的future数据加载完成......';
  }

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(HandleScroll);
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
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  _scrollController.animateTo(0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                },
                child: Icon(Icons.arrow_upward))
            : null,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
                backgroundColor: Color(0xffffffff),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: _changeBar ? Color(0xff333333) : Color(0xffffffff)),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                actions: [
                  Icon(Icons.share, color: _changeBar ? Color(0xff333333) : Color(0xffffffff)),
                  Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 10.0),
                      child: Icon(Icons.more_horiz, color: _changeBar ? Color(0xff333333) : Color(0xffffffff)))
                ],
                title: _changeBar ? TabBarWidget() : IconButton(
                  color: Color(0xffffffff),
                  icon: Icon(Icons.close),
                  onPressed: () {
                    print('colse button');
                  },
                ),
                expandedHeight: _topBarHeight,
                pinned: true,
                flexibleSpace: FutureBuilder(
                    future: getGoodsInfo(context),
                    builder: (context, snapshot) {
                      // print(snapshot.hasData);
                      if (snapshot.hasData) {
                        if(Provide.value<GoodsCommentDetailProvide>(context).goodsInfo != null) {
                              _videoUrl =
                            Provide.value<GoodsCommentDetailProvide>(context)
                                .goodsInfo
                                .data
                                .result
                                .introduce
                                .vedio;
                        var _videoImg =
                            Provide.value<GoodsCommentDetailProvide>(context)
                                .goodsInfo
                                .data
                                .result
                                .introduce
                                .vedioImg;
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
                              return FlexibleSpaceBar(
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
                                ])));
                            } else {
                              return Text('Data is null!');
                            // return Center(child: CircularProgressIndicator());
                          }
                      } else {
                        return Center(child: CircularProgressIndicator());
                        // return Center(child: Text('正在请求数据！'));
                      }
                    })),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  IntroduceWidget()
                ]
              )
            )
          ],
        ));
  }
}
